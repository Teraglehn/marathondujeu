import 'package:marathondujeu/src/data/data.dart';
import 'package:marathondujeu/src/data/repositories/repository_base.dart';
import 'package:isar_community/isar.dart';

class DrawWinnerRepository extends RepositoryBase<DrawWinner> {
  DrawWinnerRepository(super.isarClient);

  @override
  Future<IsarCollection<DrawWinner>> getCollection() async {
    return (await isarClient.db).drawWinners;
  }
  
  @override
  Future<void> write(DrawWinner obj) async {
    await Future.wait([
      if (obj.draw.isChanged) obj.draw.save(),
      if (obj.winner.isChanged) obj.winner.save(),
    ]);
  }

  Future<Stream<List<DrawWinner>>> getByDrawIdStream(int drawId) async{
    return makeStream((collection) => collection
      .filter()
      .draw((q) => q.idEqualTo(drawId))
      .build()
    );
  }

  Future<List<DrawWinner>> getByDrawId(int drawId) async{
    return makeList((collection) => collection
      .filter()
      .draw((q) => q.idEqualTo(drawId))
      .build()
    );
  }

  /// Les gagnants qui sont l'un des joueurs [playerIds] : ils partent avec eux (EV-7).
  Future<int> deleteByPlayers(Set<Id> playerIds) async {
    final collection = await getCollection();
    final ids = await collection.filter().winner((q) => q.anyOf(playerIds, (q, Id id) => q.idEqualTo(id))).idProperty().findAll();
    return deleteAll(ids.toSet());
  }
}
