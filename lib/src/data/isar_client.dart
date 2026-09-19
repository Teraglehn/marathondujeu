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
      return Isar.open([
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
    }
    return Future.value(Isar.getInstance());
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
