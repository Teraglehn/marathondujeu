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
}
