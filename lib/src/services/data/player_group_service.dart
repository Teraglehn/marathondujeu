import 'package:marathondujeu/src/data/data.dart';

class PlayerGroupService {
  final PlayerGroupRepository _playerGroupRepository;

  PlayerGroupService(this._playerGroupRepository);

  Future<PlayerGroup?> getById(int id) async {
    return await _playerGroupRepository.getById(id);
  }
  Future<Stream<PlayerGroup?>> getByIdStream(int id) async {
    return await _playerGroupRepository.getByIdStream(id);
  }

  Future<List<PlayerGroup>> getAll() async {
    return await _playerGroupRepository.getAll();
  }

  Future<Stream<List<PlayerGroup>>> getAllStream() async {
    return _playerGroupRepository.getAllStream();
  }

  Future<Stream<List<PlayerGroup>>> getByEventIdStream(int eventId) async {
    return _playerGroupRepository.getByEventIdStream(eventId);
  }

  Future<List<PlayerGroup>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _playerGroupRepository.search(searchCriteria, offset: offset, limit: limit);
  }

  Future<Stream<List<PlayerGroup>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _playerGroupRepository.searchStream(searchCriteria, offset: offset, limit: limit);
  }

  Future<void> save(PlayerGroup player) async {
    await _playerGroupRepository.save(player);
  }

  Future<void> delete(PlayerGroup player) async {
    await _playerGroupRepository.delete(player.id);
  }
}
