import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar_community/isar.dart';

class PlayerRepository extends RepositoryBase<Player> {
  PlayerRepository(super.isarClient);

  @override
  Future<IsarCollection<Player>> getCollection() async {
    return (await isarClient.db).players;
  }

  @override
  Iterable<FilterOperation> getFiltersOnKeyword(String keyword) => [FilterCondition.contains(property: "name", value: keyword, caseSensitive: false)];

  @override
  Iterable<FilterOperation> getFiltersOnEvent(Event event) => [FilterCondition.equalTo(property: "event", value: event)];
  
  @override
  Future<void> write(Player obj) async {
    await Future.wait([
      if (obj.event.isChanged) obj.event.save(),
    ]);
  }

  Future<Stream<List<Player>>> getByEventIdStream(int eventId) async{
    return makeStream((collection) => collection
      .filter()
      .event((q) => q.idEqualTo(eventId))
      .build()
    );
  }

  Future<Player?> getByQRCode(int eventId, String qrcode) async {
    final collection = await getCollection();
    final obj = await collection.filter()
      .qrcodeEqualTo(qrcode)
      .and()
      .event((q) => q.idEqualTo(eventId))
      .findFirst();
    return obj != null ? await postGet(obj) : null;
  }

}
