import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collections/collections.dart';

class IsarClient {
  late Future<Isar> db;
  final bool isTesting;
  final bool isWeb;

  IsarClient({
    this.isTesting = false,
    this.isWeb = false,
  }) {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationSupportDirectory();
      await _recoverLegacyDatabase(dir);
      final isar = await Isar.open([
          PlayerSchema,
          SessionSchema,
          EventSchema,
          DrawSchema,
          DrawWinnerSchema,
          PlayerGroupSchema
        ], 
        inspector: isTesting, 
        directory: isWeb ? "" : dir.path
      );
      await migratePlayerNumbers(isar);
      await migratePlayerGroupKinds(isar);
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  /// Donne un numéro aux joueurs créés avant le champ `Player.number` (L05) : une seule fois,
  /// ceux qui n'en ont pas encore.
  static Future<void> migratePlayerNumbers(Isar isar) async {
    final players = await isar.players.filter().numberLessThan(1).findAll();
    if (players.isEmpty) return;
    for (final p in players) {
      p.number = p.inferNumber();
    }
    await isar.writeTxn(() => isar.players.putAll(players));
  }

  /// Catégorise les groupes créés avant le champ `PlayerGroup.kind` (L16) : ceux qu'un tirage
  /// tient par `winnersGroup` sont des groupes de gagnants. Sans effet une fois faits.
  static Future<void> migratePlayerGroupKinds(Isar isar) async {
    final draws = await isar.draws.filter().winnersGroup((q) => q.kindEqualTo(PlayerGroupKind.manual)).findAll();
    if (draws.isEmpty) return;
    final groups = <PlayerGroup>[];
    for (final d in draws) {
      await d.winnersGroup.load();
      groups.add(d.winnersGroup.value!..kind = PlayerGroupKind.winners);
    }
    await isar.writeTxn(() => isar.playerGroups.putAll(groups));
  }

  /// Reprend la base des versions précédentes, qui vivait dans le dossier cache
  /// de `com.example`. Copie seulement : l'ancien fichier reste en place.
  Future<void> _recoverLegacyDatabase(Directory dir) async {
    if (!Platform.isWindows) return;
    final localAppData = Platform.environment['LOCALAPPDATA'];
    if (localAppData == null) return;
    final target = File('${dir.path}${Platform.pathSeparator}default.isar');
    if (await target.exists()) return;
    final legacy = File([localAppData, 'com.example', 'marathondujeu', 'default.isar']
        .join(Platform.pathSeparator));
    if (!await legacy.exists()) return;
    await dir.create(recursive: true);
    await legacy.copy(target.path);
  }
}
