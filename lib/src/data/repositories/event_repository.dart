import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar_community/isar.dart';

class EventRepository extends RepositoryBase<Event> {
  EventRepository(super.isarClient);

  @override
  Future<IsarCollection<Event>> getCollection() async {
    return (await isarClient.db).events;
  }
  
  @override
  Future<void> write(Event obj) async {
    await Future.wait([
      if (obj.sessions.isChanged) obj.sessions.save(),
      if (obj.players.isChanged) obj.players.save(),
    ]);
  }
}
