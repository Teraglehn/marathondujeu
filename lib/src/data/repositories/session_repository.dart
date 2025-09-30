import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar/isar.dart';

class SessionRepository extends RepositoryBase<Session> {
  SessionRepository(super.isarClient);

  @override
  Future<IsarCollection<Session>> getCollection() async {
    return (await isarClient.db).sessions;
  }
  
  @override
  Future<void> write(Session obj) async {
    await Future.wait([
      if (obj.players.isChanged) obj.players.save(),
      if (obj.event.isChanged) obj.event.save(),
    ]);
  }

  Future<Stream<List<Session>>> getByEventIdStream(int eventId) async{
    return makeStream((collection) => collection
      .filter()
      .event((q) => q.idEqualTo(eventId))
      .build()
    );
  }
  
  Future<List<Session>> getOpenned(int eventId, DateTime time) async {
    final collection = await getCollection();
    final objs = await collection
      .filter()
      .event((q) => q.idEqualTo(eventId))
      .and()
      .startTimeLessThan(time, include: true)
      .and()
      .endTimeGreaterThan(time, include: true)
      .findAll();
    return await Future.wait(objs.map(postGet));
  }
}
