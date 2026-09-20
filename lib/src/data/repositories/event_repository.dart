import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar_community/isar.dart';
import 'package:uuid/uuid.dart';

class EventRepository extends RepositoryBase<Event> {
  EventRepository(super.isarClient);

  @override
  Future<IsarCollection<Event>> getCollection() async {
    return (await isarClient.db).events;
  }
  
  /// L'identifiant stable (L09) : posé à la première écriture, jamais changé ensuite.
  @override
  Future<void> preSave(Event obj) async {
    if (obj.uid.isEmpty) obj.uid = const Uuid().v4();
  }

  @override
  Future<void> write(Event obj) async {
    await Future.wait([
      if (obj.sessions.isChanged) obj.sessions.save(),
      if (obj.players.isChanged) obj.players.save(),
    ]);
  }
}
