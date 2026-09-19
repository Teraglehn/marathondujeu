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

  Future<Stream<Event?>> getByIdStream(int id) async {
    return _eventRepository.getByIdStream(id);
  }

  Future<List<Event>> search(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _eventRepository.search(searchCriteria, offset: offset, limit: limit);
  }

  Future<Stream<List<Event>>> searchStream(SearchCriteria searchCriteria, {int? offset, int? limit}) async {
    return await _eventRepository.searchStream(searchCriteria, offset: offset, limit: limit);
  }

  Future<void> save(Event event, {bool generateSessions = false}) async {
    await _eventRepository.save(event);
    if(generateSessions){
      await destroySessions(event);
      await this.generateSessions(event);
    }
  }

  Future<void> delete(Event event) async {
    await _eventRepository.delete(event.id);
  }

  Future<void> generateSessions(Event event) async {
    DateTime sessionStart = event.startDateTime;
    final DateTime end = event.endDateTime;
    List<Session> sessions = [];
    int number = 1;

    while (sessionStart.isBefore(end)) {
      sessions.add(Session.fromEvent(sessionStart, number++, event));
      sessionStart = sessionStart.add(Duration(minutes: event.sessionIntervalMinutes));
    }
    
    await _sessionRepository.saveAll(sessions);
  }

  Future<void> destroySessions(Event event) async {
    await event.sessions.load();
    await _sessionRepository.deleteAll(event.sessions.map((e)=> e.id).toSet());
  }
  
  
  Future<void> addPlayerToOpenedSession(Event event, Player player, {void Function(Player)? success}) async {
    final sessions = await _sessionRepository.getOpenned(event.id, DateTime.now());

    if(sessions.isEmpty) return;

    final session = sessions.first;

    if(session.players.contains(player)) return;
    
    session.addPlayer(player);
    await _sessionRepository.save(sessions.first);
    success?.call(player);
  }


  Future<void> forceAddPlayerToSession(Event event, Session session, Player player, {void Function(Player)? success}) async {
    if(session.players.contains(player)) return;

    session.forceAddPlayer(player);
    await _sessionRepository.save(session);
    success?.call(player);
  }

  /// Badge le joueur sur les sessions [added] et le retire des sessions [removed],
  /// en une seule transaction.
  Future<void> setPlayerSessions(Player player, {required Set<int> added, required Set<int> removed}) async {
    final sessions = <Session>[];
    for (final id in added) {
      final session = await _sessionRepository.getById(id);
      if (session == null) continue;
      session.players.add(player);
      sessions.add(session);
    }
    for (final id in removed) {
      final session = await _sessionRepository.getById(id);
      if (session == null) continue;
      session.players.remove(player);
      sessions.add(session);
    }
    await _sessionRepository.saveAll(sessions);
  }

  void scanPlayerToSession(Event event, String qrCode, {Session? session, bool force = false, void Function(Player)? success}) async {
    final player = await getPlayerByQrCode(event, qrCode);
    if(player == null) return;
    
    if(session != null){
      if(force){
        await forceAddPlayerToSession(event, session, player, success: success);
      }
    } else {
      await addPlayerToOpenedSession(event, player, success: success);
    }
  }

  Future<Player?> getPlayerByQrCode(Event event, String qrCode) async {
    qrCode = qrCode.split("").map((e) => e.trim()).join("");
    if(qrCode.isEmpty) return null;

    return await _playerRepository.getByQRCode(event.id, qrCode);
  }
 
  Future<void> generateMissingPlayers(Event event, int playerCount) async {
    await event.players.load();
    List<Player> players = event.players.toList();

    if(playerCount<players.length) return;

    for(var i = players.length+1; i < (playerCount+1); i++){
      players.add(Player.empty()
        ..name = i.toString()
        ..qrcode = event.qrSalt + i.toString()
        ..event.value = event
      );
    }

    await _playerRepository.saveAll(players);
  }

  Future<void> destroyPlayers(Event event) async {
    await event.players.load();
    await _playerRepository.deleteAll(event.players.map((e)=> e.id).toSet());
  }
}
