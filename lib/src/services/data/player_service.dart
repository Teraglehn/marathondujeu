import 'package:marathondujeu/src/data/data.dart';

class PlayerService {
  final PlayerRepository _playerRepository;

  PlayerService(this._playerRepository);

  Future<Player?> getById(int id) async {
    return await _playerRepository.getById(id);
  }

  Future<Player?> getByQRCode(int enventId, String qrcode) async {
    return await _playerRepository.getByQRCode(enventId, qrcode);
  }

  Future<List<Player>> getAll() async {
    return await _playerRepository.getAll();
  }

  Future<Stream<List<Player>>> getAllStream() async {
    return _playerRepository.getAllStream();
  }

  Future<Stream<List<Player>>> getByEventIdStream(int eventId) async {
    return _playerRepository.getByEventIdStream(eventId);
  }

  Future<List<Player>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _playerRepository.search(searchCriteria, offset: offset, limit: limit);
  }

  Future<Stream<List<Player>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _playerRepository.searchStream(searchCriteria, offset: offset, limit: limit);
  }

  Future<void> save(Player player) async {
    await _playerRepository.save(player);
  }

  Future<void> delete(Player player) async {
    await _playerRepository.delete(player.id);
  }
}
