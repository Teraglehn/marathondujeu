import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar_community/isar.dart';

class PlayerGroupRepository extends RepositoryBase<PlayerGroup> {
  PlayerGroupRepository(super.isarClient);

  @override
  Future<IsarCollection<PlayerGroup>> getCollection() async {
    return (await isarClient.db).playerGroups;
  }

  @override
  Iterable<FilterOperation> getFiltersOnKeyword(String keyword) => [FilterCondition.contains(property: "name", value: keyword, caseSensitive: false)];

  @override
  Iterable<FilterOperation> getFiltersOnEvent(Event event) => [FilterCondition.equalTo(property: "event", value: event)];
  
  @override
  Future<void> write(PlayerGroup obj) async {
    await Future.wait([
      if (obj.event.isChanged) obj.event.save(),
      if (obj.players.isChanged) obj.players.save(),
    ]);
  }

  Future<Stream<List<PlayerGroup>>> getByEventIdStream(int eventId) async{
    return makeStream((collection) => collection
      .filter()
      .event((q) => q.idEqualTo(eventId))
      .build()
    );
  }

}
