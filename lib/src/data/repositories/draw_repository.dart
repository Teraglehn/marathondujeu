import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar/isar.dart';

class DrawRepository extends RepositoryBase<Draw> {
  DrawRepository(super.isarClient);

  @override
  Future<IsarCollection<Draw>> getCollection() async {
    return (await isarClient.db).draws;
  }
  
  @override
  Future<void> write(Draw obj) async {
    await Future.wait([
      if (obj.event.isChanged) obj.event.save(),
      if (obj.excludedPlayers.isChanged) obj.excludedPlayers.save(),
      if (obj.excludedSessions.isChanged) obj.excludedSessions.save(),
      if (obj.requiredSessions.isChanged) obj.requiredSessions.save(),
    ]);
  }

  Future<Stream<List<Draw>>> getByEventIdStream(int eventId) async{
    return makeStream((collection) => collection
      .filter()
      .event((q) => q.idEqualTo(eventId))
      .build()
    );
  }
}
