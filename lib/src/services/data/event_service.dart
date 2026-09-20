import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';

class EventService {
  final SessionRepository _sessionRepository;
  final EventRepository _eventRepository;
  final PlayerRepository _playerRepository;
  final DrawWinnerRepository _drawWinnerRepository;

  EventService(this._sessionRepository, this._eventRepository, this._playerRepository, this._drawWinnerRepository);

  Future<Event?> getById(int id) async {
    return await _eventRepository.getById(id);
  }

  Future<List<Event>> getAll() async {
    return await _eventRepository.getAll();
  }

  Future<Stream<List<Event>>> getAllStream() async {
    return _eventRepository.getAllStream();
  }

  Future<Stream<Event?>> getByIdStream(int id) async {
    return _eventRepository.getByIdStream(id);
  }

  Future<List<Event>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _eventRepository.search(searchCriteria, offset: offset, limit: limit);
  }

  Future<Stream<List<Event>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _eventRepository.searchStream(searchCriteria, offset: offset, limit: limit);
  }

  /// Un événement neuf reçoit toujours ses sessions ; un existant les recrée sur
  /// [regenerateSessions] (paramètres de session changés) — ses badgeages sont perdus.
  Future<void> save(Event event, {bool regenerateSessions = false}) async {
    final isNew = !event.exist;
    await _eventRepository.save(event);
    if(isNew || regenerateSessions){
      await destroySessions(event);
      await generateSessions(event);
    }
  }

  /// Ferme un événement (L21) : le supprime avec tout ce qui s'y rattache — gagnants, tirages,
  /// groupes, sessions, joueurs —, en une transaction. Son fichier de sauvegarde n'est pas touché.
  Future<void> destroyEvent(Event event) async {
    final isar = await _eventRepository.isarClient.db;
    await isar.writeTxn(() => destroyEventIn(isar, event));
  }

  /// La cascade elle-même, dans une transaction déjà ouverte (l'ouverture d'un fichier de
  /// sauvegarde remplace un événement dans la sienne).
  static Future<void> destroyEventIn(Isar isar, Event event) async {
    final draws = await isar.draws.filter().event((q) => q.idEqualTo(event.id)).findAll();
    for (final d in draws) {
      await d.winners.load();
      await isar.drawWinners.deleteAll(d.winners.map((w) => w.id).toList());
    }
    await isar.draws.deleteAll(draws.map((d) => d.id).toList());
    await isar.playerGroups.filter().event((q) => q.idEqualTo(event.id)).deleteAll();
    await isar.sessions.filter().event((q) => q.idEqualTo(event.id)).deleteAll();
    await isar.players.filter().event((q) => q.idEqualTo(event.id)).deleteAll();
    await isar.events.delete(event.id);
  }

  Future<void> generateSessions(Event event) async {
    final starts = sessionStarts(event.startDateTime, event.endDateTime, event.sessionIntervalMinutes);
    final sessions = [for (final (i, start) in starts.indexed) Session.fromEvent(start, i + 1, event)];
    await _sessionRepository.saveAll(sessions);
  }

  /// Les débuts des sessions d'un événement : de [start], toutes les [intervalMinutes], tant
  /// qu'on est avant [end]. Le même calcul sert à l'aperçu de l'éditeur d'événement. Rien
  /// pour un intervalle nul ou négatif.
  static List<DateTime> sessionStarts(DateTime start, DateTime end, int intervalMinutes) {
    if (intervalMinutes <= 0) return const [];
    final starts = <DateTime>[];
    for (var s = start; s.isBefore(end); s = s.add(Duration(minutes: intervalMinutes))) {
      starts.add(s);
    }
    return starts;
  }

  /// Le nombre de badgeages de l'événement : ce que regénérer les sessions perd.
  Future<int> countBadges(Event event) async {
    if(!event.exist) return 0;
    await event.sessions.load();
    var count = 0;
    for (final session in event.sessions) {
      await session.players.load();
      count += session.players.length;
    }
    return count;
  }

  Future<void> destroySessions(Event event) async {
    await event.sessions.load();
    await _sessionRepository.deleteAll(event.sessions.map((e)=> e.id).toSet());
  }
  
  
  /// Badge le joueur sur la session ouverte à [now] ; aucune → `ScanNoOpenSession`.
  Future<ScanResult> badgeOpenSession(Event event, Player player, {DateTime? now}) async {
    final sessions = await _sessionRepository.getOpenned(event.id, now ?? DateTime.now());
    if(sessions.isEmpty) return const ScanNoOpenSession();

    return badgeSession(sessions.first, player, manual: true, now: now);
  }

  /// Badge le joueur sur [session] si elle est ouverte à [now], ou en badgeage [manual] ;
  /// sinon `ScanSessionNotOpen`. Déjà présent → `ScanAlreadyPresent`, rien n'est écrit.
  Future<ScanResult> badgeSession(Session session, Player player, {required bool manual, DateTime? now}) async {
    if(!manual && !session.isOpenAt(now ?? DateTime.now())) return ScanSessionNotOpen(session);
    if(session.players.contains(player)) return ScanAlreadyPresent(player, session);

    session.forceAddPlayer(player);
    await _sessionRepository.save(session);
    return ScanBadged(player, session);
  }


  /// Retire le joueur de la session, écrit tout de suite. Sans effet s'il n'y est pas.
  Future<void> removePlayerFromSession(Session session, Player player) async {
    if(!session.players.contains(player)) return;

    session.players.remove(player);
    await _sessionRepository.save(session);
  }

  /// Le mode suppression : retire le joueur, ou dit qu'il n'y était pas (`ScanNotPresent`).
  Future<ScanResult> unbadgeSession(Session session, Player player) async {
    if(!session.players.contains(player)) return ScanNotPresent(player, session);

    await removePlayerFromSession(session, player);
    return ScanRemovedFromSession(player, session);
  }

  /// Badge le joueur sur les sessions [added] et le retire des sessions [removed],
  /// en une seule transaction.
  Future<void> setPlayerSessions(Player player, {required Set<int> added, required Set<int> removed}) async {
    final sessions = <Session>[];
    for (final id in added) {
      final session = await _sessionRepository.getById(id);
      if (session == null) continue;
      session.players.add(player);
      sessions.add(session);
    }
    for (final id in removed) {
      final session = await _sessionRepository.getById(id);
      if (session == null) continue;
      session.players.remove(player);
      sessions.add(session);
    }
    await _sessionRepository.saveAll(sessions);
  }

  Future<Player?> getPlayerByQrCode(Event event, String qrCode) async {
    qrCode = qrCode.split("").map((e) => e.trim()).join("");
    if(qrCode.isEmpty) return null;

    return await _playerRepository.getByQRCode(event.id, qrCode);
  }
 
  Future<void> generateMissingPlayers(Event event, int playerCount) async {
    await event.players.load();
    List<Player> players = event.players.toList();

    if(playerCount<players.length) return;

    for(var i = players.length+1; i < (playerCount+1); i++){
      players.add(Player.empty()
        ..name = i.toString()
        ..number = i
        ..qrcode = event.qrCodeFor(i)
        ..event.value = event
      );
    }

    await _playerRepository.saveAll(players);
  }

  /// Supprime les joueurs de l'événement ; leurs badgeages (des liens) et leurs places de
  /// gagnants partent avec eux — un gagnant sans joueur n'a plus de sens (L18).
  Future<void> destroyPlayers(Event event) async {
    await event.players.load();
    final ids = event.players.map((e)=> e.id).toSet();
    await _drawWinnerRepository.deleteByPlayers(ids);
    await _playerRepository.deleteAll(ids);
  }
}
