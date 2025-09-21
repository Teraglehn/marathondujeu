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

  
  Future<List<Session>> getOpenned(DateTime time) async {
    final collection = await getCollection();
    final objs = await collection
      .filter()
      .startTimeLessThan(time, include: true)
      .and()
      .group((q) => q
        .endTimeIsNull()
        .or()
        .endTimeGreaterThan(time, include: true)
      ).findAll();
    return await Future.wait(objs.map(postGet));
  }
}
