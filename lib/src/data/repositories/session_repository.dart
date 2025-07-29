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
    ]);
  }
}
