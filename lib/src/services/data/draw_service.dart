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

  Future<void> save(Draw event) async {
    await _drawRepository.save(event);
  }

  Future<void> delete(Draw event) async {
    await _drawRepository.delete(event.id);
  }

}
