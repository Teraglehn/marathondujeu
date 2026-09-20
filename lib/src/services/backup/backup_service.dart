import 'dart:async';
import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/isar_client.dart';
import 'package:marathondujeu/src/services/backup/backup_format.dart';
import 'package:marathondujeu/src/services/data/event_service.dart';

/// Ce que l'ouverture d'un fichier a trouvé avant d'écrire : l'événement du fichier, et celui
/// qui porte déjà le même `uid` en base, s'il y en a un (Q2 : *Remplacer* ou *Annuler*).
class BackupOpening {
  final EventBackup backup;
  final Event? existing;
  const BackupOpening(this.backup, this.existing);
}

/// Un échec d'écriture du fichier d'un événement (dossier disparu, disque plein…).
class BackupWriteError {
  final Event event;
  final Object error;
  const BackupWriteError(this.event, this.error);
}

/// Le fichier de sauvegarde de chaque événement (L09). **Écriture** : à chaque modification en
/// base — les six collections sont surveillées —, le fichier de chaque événement qui en a un
/// est réécrit, après [delay] sans nouvelle modification et au plus [maxDelay] après la
/// première (Q3) ; écriture atomique (`.tmp` puis remplacement, C3). **Lecture** : un fichier
/// est décodé, comparé à la base par `uid`, puis son événement est ajouté ou remplace l'existant,
/// en une transaction.
class BackupService {
  final IsarClient isarClient;
  final Duration delay;
  final Duration maxDelay;

  /// Ce que l'interface fait d'un échec d'écriture ; rien par défaut (les tests).
  void Function(BackupWriteError error)? onError;

  /// Au démarrage, un événement dont le dossier du fichier a disparu perd son chemin (Q4) : ce
  /// que l'interface en dit.
  void Function(Event event)? onPathLost;

  /// L'heure de la dernière écriture réussie, par événement.
  final Map<int, DateTime> lastWrittenAt = {};

  /// Le nombre de fichiers écrits depuis le départ (les tests comptent).
  int writes = 0;

  Timer? _timer;
  DateTime? _firstChangeAt;
  final List<StreamSubscription<void>> _subscriptions = [];
  // Les écritures se suivent, jamais en parallèle : deux sur le même fichier se marcheraient
  // dessus (même `.tmp`).
  Future<void> _chain = Future.value();
  int _busy = 0;

  BackupService(this.isarClient, {this.delay = const Duration(seconds: 2), this.maxDelay = const Duration(seconds: 30)});

  /// Surveille la base : toute écriture appelle [changed]. Avant, les chemins dont le dossier
  /// n'existe plus sont retirés.
  Future<void> start() async {
    final isar = await isarClient.db;
    final lost = (await isar.events.filter().backupPathIsNotNull().findAll())
      .where((e) => !File(e.backupPath!).parent.existsSync()).toList();
    if (lost.isNotEmpty) {
      for (final e in lost) {
        e.backupPath = null;
      }
      await isar.writeTxn(() => isar.events.putAll(lost));
      for (final e in lost) {
        onPathLost?.call(e);
      }
    }
    for (final collection in [isar.events, isar.players, isar.sessions, isar.playerGroups, isar.draws, isar.drawWinners]) {
      _subscriptions.add(collection.watchLazy().listen((_) => changed()));
    }
  }

  Future<void> dispose() async {
    _timer?.cancel();
    for (final s in _subscriptions) {
      await s.cancel();
    }
    _subscriptions.clear();
  }

  /// Une modification en base : l'écriture part après [delay] de calme, ou tout de suite si la
  /// première modification en attente a plus de [maxDelay].
  void changed() {
    final now = DateTime.now();
    _firstChangeAt ??= now;
    _timer?.cancel();
    if (now.difference(_firstChangeAt!) >= maxDelay) {
      _timer = null;
      flush();
      return;
    }
    _timer = Timer(delay, flush);
  }

  /// Vrai tant qu'une écriture est en attente ou en cours.
  bool get pending => _timer != null || _busy > 0;

  Future<T> _serialized<T>(Future<T> Function() job) {
    _busy++;
    final result = _chain.then((_) => job()).whenComplete(() => _busy--);
    _chain = result.then((_) {}, onError: (_) {});
    return result;
  }

  /// Écrit maintenant ce qui est en attente ; attend la fin. À la fermeture de l'application.
  Future<void> flush() {
    _timer?.cancel();
    _timer = null;
    _firstChangeAt = null;
    return _serialized(() async {
      final isar = await isarClient.db;
      final events = await isar.events.filter().backupPathIsNotNull().findAll();
      for (final event in events) {
        await _write(isar, event);
      }
    });
  }

  /// Écrit le fichier de [event] tout de suite, à la suite des écritures en cours ; vrai si
  /// c'est fait — la fermeture d'un événement (L21) s'en sert pour dire « sauvegardé ».
  Future<bool> writeNow(Event event) => _serialized(() async => _write(await isarClient.db, event));

  Future<bool> _write(Isar isar, Event event) async {
    try {
      await writeEvent(isar, event);
      lastWrittenAt[event.id] = DateTime.now();
      writes++;
      return true;
    } catch (e) {
      onError?.call(BackupWriteError(event, e));
      return false;
    }
  }

  /// Écrit le fichier de [event] à `event.backupPath` : le JSON dans `<fichier>.tmp`, puis le
  /// remplacement — jamais un fichier à moitié écrit.
  Future<void> writeEvent(Isar isar, Event event) async {
    final path = event.backupPath!;
    final text = BackupFormat.encode(await snapshot(isar, event));
    final tmp = File('$path.tmp');
    await tmp.writeAsString(text, flush: true);
    await tmp.rename(path);
  }

  /// Tout l'événement, liens chargés, prêt pour le format — lu dans **une** transaction : un
  /// cliché pris en plusieurs requêtes pourrait enjamber une fermeture ou un remplacement de
  /// l'événement et écrire un fichier à moitié vide.
  static Future<EventBackup> snapshot(Isar isar, Event event) => isar.txn(() => _snapshot(isar, event));

  static Future<EventBackup> _snapshot(Isar isar, Event event) async {
    final players = await isar.players.filter().event((q) => q.idEqualTo(event.id)).sortByNumber().findAll();
    final sessions = await isar.sessions.filter().event((q) => q.idEqualTo(event.id)).sortByNumber().findAll();
    final groups = await isar.playerGroups.filter().event((q) => q.idEqualTo(event.id)).findAll();
    final draws = await isar.draws.filter().event((q) => q.idEqualTo(event.id)).findAll();
    for (final s in sessions) {
      await s.players.load();
    }
    for (final g in groups) {
      await g.players.load();
    }
    final winners = <List<DrawWinner>>[];
    for (final d in draws) {
      await Future.wait([
        d.excludedSessions.load(), d.requiredSessions.load(),
        d.excludedGroups.load(), d.requiredGroups.load(),
        d.excludedPlayers.load(), d.requiredPlayers.load(),
        d.winnersGroup.load(), d.winners.load(),
      ]);
      final list = d.winners.toList()..sort((a, b) => a.position.compareTo(b.position));
      for (final w in list) {
        await w.winner.load();
      }
      winners.add(list);
    }
    return EventBackup(event: event, players: players, sessions: sessions, groups: groups, draws: draws, winners: winners);
  }

  // ------------------------------------------------------------------ lecture

  /// Lit et décode le fichier, et cherche en base l'événement de même `uid`. N'écrit rien.
  /// Lève [BackupFormatException] pour un fichier illisible, [FileSystemException] pour un
  /// fichier absent.
  Future<BackupOpening> open(String path) async {
    final backup = BackupFormat.decode(await File(path).readAsString());
    final isar = await isarClient.db;
    final existing = backup.event.uid.isEmpty ? null : await isar.events.filter().uidEqualTo(backup.event.uid).findFirst();
    return BackupOpening(backup, existing);
  }

  /// Ajoute l'événement du fichier à la base — après avoir supprimé [replace] et tout ce qui
  /// s'y rattache, s'il est donné —, en une transaction. Rend l'événement enregistré.
  Future<Event> import(EventBackup backup, {Event? replace}) async {
    final isar = await isarClient.db;
    await isar.writeTxn(() async {
      if (replace != null) await EventService.destroyEventIn(isar, replace);
      final event = backup.event;
      // Le fichier ne porte pas de chemin (Q4) ; un événement remplacé garde le sien.
      event.backupPath = replace?.backupPath;
      await isar.events.put(event);
      await isar.players.putAll(backup.players);
      for (final p in backup.players) {
        await p.event.save();
      }
      await isar.sessions.putAll(backup.sessions);
      for (final s in backup.sessions) {
        await Future.wait([s.event.save(), s.players.save()]);
      }
      await isar.playerGroups.putAll(backup.groups);
      for (final g in backup.groups) {
        await Future.wait([g.event.save(), g.players.save()]);
      }
      await isar.draws.putAll(backup.draws);
      for (final d in backup.draws) {
        await Future.wait([
          d.event.save(),
          d.excludedSessions.save(), d.requiredSessions.save(),
          d.excludedGroups.save(), d.requiredGroups.save(),
          d.excludedPlayers.save(), d.requiredPlayers.save(),
          d.winnersGroup.save(),
        ]);
      }
      final winners = backup.winners.expand((w) => w).toList();
      await isar.drawWinners.putAll(winners);
      for (final w in winners) {
        await Future.wait([w.draw.save(), w.winner.save()]);
      }
    });
    return backup.event;
  }
}
