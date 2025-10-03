import 'package:isar/isar.dart';
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
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open([
          PlayerSchema,
          SessionSchema,
          EventSchema,
          DrawSchema,
          DrawWinnerSchema
        ], 
        inspector: isTesting, 
        directory: isWeb ? "" : dir.path
      );
    }
    return Future.value(Isar.getInstance());
  }
}
