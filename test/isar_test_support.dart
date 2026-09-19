import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/isar_client.dart';

/// Ouvre une base Isar jetable dans un dossier temporaire, avec les schémas de
/// l'application. La lib native est celle livrée par `isar_community_flutter_libs`,
/// localisée via `.dart_tool/package_config.json` (les tests tournent à la racine).
Future<Isar> openTestIsar() async {
  final config = jsonDecode(await File('.dart_tool/package_config.json').readAsString());
  final package = (config['packages'] as List).firstWhere((p) => p['name'] == 'isar_community_flutter_libs');
  final root = Directory.fromUri(Uri.parse(package['rootUri'] as String)).path;
  final dll = [root, 'windows', 'libisar.dll'].join(Platform.pathSeparator);
  await Isar.initializeIsarCore(libraries: {Abi.windowsX64: dll});
  final dir = await Directory.systemTemp.createTemp('marathondujeu_test_');
  return Isar.open(
    [PlayerSchema, SessionSchema, EventSchema, DrawSchema, DrawWinnerSchema, PlayerGroupSchema],
    directory: dir.path,
    name: dir.path.hashCode.toRadixString(16),
  );
}

/// Client qui sert une base déjà ouverte au lieu d'en ouvrir une sur le poste.
class TestIsarClient extends IsarClient {
  final Isar isar;
  TestIsarClient(this.isar);

  @override
  Future<Isar> openDB() async => isar;
}
