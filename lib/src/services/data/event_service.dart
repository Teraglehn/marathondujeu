import 'package:marathondujeu/src/data/data.dart';

class EventService {
  final SessionRepository _sessionRepository;
  final EventRepository _eventRepository;
  final PlayerRepository _playerRepository;

  EventService(this._sessionRepository, this._eventRepository, this._playerRepository);

  Future<Event?> getById(int id) async {
    return await _eventRepository.getById(id);
  }

  Future<List<Event>> getAll() async {
    return await _eventRepository.getAll();
  }

  Future<Stream<List<Event>>> getAllStream() async {
    return _eventRepository.getAllStream();
  }

  Future<List<Event>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _eventRepository.search(searchCriteria, offset: offset, limit: limit);
  }

  Future<Stream<List<Event>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _eventRepository.searchStream(searchCriteria, offset: offset, limit: limit);
  }

  Future<void> save(Event event) async {
    await _eventRepository.save(event);
  }

  Future<void> delete(Event event) async {
    await _eventRepository.delete(event.id);
  }

  Future<void> generateSessions(Event event) async {
    DateTime sessionStart = event.startDateTime;
    final DateTime end = event.endDateTime;
    List<Session> sessions = [];

    while (sessionStart.isBefore(end)) {
      sessions.add(Session.fromEvent(sessionStart, event));
      sessionStart = sessionStart.add(Duration(minutes: event.sessionIntervalMinutes));
    }
    
    await _sessionRepository.saveAll(sessions);
  }

  Future<void> generatePlayers(Event event, int playerCount) async {
    List<Player> players = [];
    for(var i = 1; i < (playerCount+1); i++){
      players.add(Player.empty()
        ..name = i.toString()
        ..qrcode = event.qrSalt + i.toString()
        ..event.value = event
      );
    }

    await _playerRepository.saveAll(players);
  }
}
