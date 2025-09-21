import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar/isar.dart';

class PlayerRepository extends RepositoryBase<Player> {
  PlayerRepository(super.isarClient);

  @override
  Future<IsarCollection<Player>> getCollection() async {
    return (await isarClient.db).players;
  }

  @override
  Iterable<FilterOperation> getFiltersOnKeyword(String keyword) => [FilterCondition.contains(property: "name", value: keyword, caseSensitive: false)];

  
  @override
  Future<void> write(Player obj) async {
    await Future.wait([
      if (obj.event.isChanged) obj.event.save(),
    ]);
  }
  

  Future<Player?> getByQRCode(String qrcode) async {
    final collection = await getCollection();
    final obj = await collection.getByQrcode(qrcode);
    return obj != null ? await postGet(obj) : null;
  }

}
