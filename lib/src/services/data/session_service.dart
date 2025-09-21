import 'package:marathondujeu/src/data/data.dart';

class SessionService {
  final SessionRepository _sessionRepository;

  SessionService(this._sessionRepository);

  Future<Session?> getById(int id) async {
    return await _sessionRepository.getById(id);
  }

  Future<List<Session>> getOpenedSession(DateTime time) async {
    return await _sessionRepository.getOpenned(time);
  }

  Future<List<Session>> getAll() async {
    return await _sessionRepository.getAll();
  }

  Future<Stream<List<Session>>> getAllStream() async {
    return _sessionRepository.getAllStream();
  }

  Future<List<Session>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _sessionRepository.search(searchCriteria, offset: offset, limit: limit);
  }

  Future<Stream<List<Session>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _sessionRepository.searchStream(searchCriteria, offset: offset, limit: limit);
  }

  Future<void> save(Session session) async {
    await _sessionRepository.save(session);
  }

  Future<void> delete(Session session) async {
    await _sessionRepository.delete(session.id);
  }
}
