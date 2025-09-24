import 'package:marathondujeu/src/data/data.dart';

class DrawService {
  final DrawRepository _drawRepository;

  DrawService(this._drawRepository);

  Future<Draw?> getById(int id) async {
    return await _drawRepository.getById(id);
  }

  Future<List<Draw>> getAll() async {
    return await _drawRepository.getAll();
  }

  Future<Stream<List<Draw>>> getAllStream() async {
    return _drawRepository.getAllStream();
  }

  Future<List<Draw>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _drawRepository.search(searchCriteria, offset: offset, limit: limit);
  }

  Future<Stream<List<Draw>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _drawRepository.searchStream(searchCriteria, offset: offset, limit: limit);
  }

  Future<void> save(Draw draw) async {
    await _drawRepository.save(draw);
  }

  Future<void> delete(Draw draw) async {
    await _drawRepository.delete(draw.id);
  }

  Future<void> createDrawFromDraw(Draw previousDraw) async {
    Draw nextDraw = Draw.empty()
      ..minSessionNumber = previousDraw.minSessionNumber
      ..maxSessionNumber = previousDraw.maxSessionNumber
      ..excludedPlayers.addAll(previousDraw.excludedPlayers)
      ..requiredSessions.addAll(previousDraw.requiredSessions)
      ..excludedSessions.addAll(previousDraw.excludedSessions)
      ..event.value = previousDraw.event.value;

    if(previousDraw.winner.value != null){
      nextDraw.excludedPlayers.add(previousDraw.winner.value!);
    }
  }

  Future<void> calculateDraw(Draw draw) async {

  }

}
