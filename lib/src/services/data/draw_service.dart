import 'dart:math';

import 'package:marathondujeu/src/data/data.dart';

class DrawService {
  final DrawRepository _drawRepository;
  final DrawWinnerRepository _drawWinnerRepository;
  final Random _random;

  DrawService(this._drawRepository, this._drawWinnerRepository, {Random? random})
      : _random = random ?? Random.secure();

  Future<Draw?> getById(int id) async {
    return await _drawRepository.getById(id);
  }

  Future<List<Draw>> getAll() async {
    return await _drawRepository.getAll();
  }

  Future<Stream<List<Draw>>> getAllStream() async {
    return _drawRepository.getAllStream();
  }

  Future<Stream<List<Draw>>> getByEventIdStream(int eventId) async {
    return _drawRepository.getByEventIdStream(eventId);
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
      ..name = "${previousDraw.name} - copie"
      ..minSessionNumber = previousDraw.minSessionNumber
      ..maxSessionNumber = previousDraw.maxSessionNumber
      ..excludedPlayers.addAll(previousDraw.excludedPlayers)
      ..requiredSessions.addAll(previousDraw.requiredSessions)
      ..excludedSessions.addAll(previousDraw.excludedSessions)
      ..event.value = previousDraw.event.value;

    await previousDraw.winners.load();

    if(previousDraw.winners.isNotEmpty){
      nextDraw.excludedPlayers.addAll(previousDraw.winners.where((e)=>e.winner.value != null).map((e)=> e.winner.value!));
    }
  }
  
  
  Set<Player> _getPlayerList(Event event, int minSessionNumber, int maxSessionNumber, Set<Player> excludedPlayers, Set<Player> requiredPlayers, Set<Session> excludedSessions, Set<Session> requiredSessions) {
    Set<Player> players = event.players.toSet();
    if(requiredPlayers.isNotEmpty) players = requiredPlayers.toSet();

    if(minSessionNumber > 0){
      players.removeWhere((p) => p.getSessionNumber() < minSessionNumber);
    }

    if(maxSessionNumber > 0){
      players.removeWhere((p) => p.getSessionNumber() > maxSessionNumber);
    }

    if(excludedPlayers.isNotEmpty) players.removeAll(excludedPlayers);
    if(excludedSessions.isNotEmpty) players.removeWhere((p) => p.sessions.intersection(excludedSessions).isNotEmpty);
    if(requiredSessions.isNotEmpty) players.removeWhere((p) => p.sessions.intersection(requiredSessions).length < requiredSessions.length);

    return players;
  }

  Future<int> getPlayerCount(Event event, int minSessionNumber, int maxSessionNumber, Set<Player> excludedPlayers, Set<Player> requiredPlayers, Set<Session> excludedSessions, Set<Session> requiredSessions) async {
    return _getPlayerList(event, minSessionNumber, maxSessionNumber, excludedPlayers, requiredPlayers, excludedSessions, requiredSessions).length;
  }

  Future<Set<Player>> getPlayerList(Draw draw) async {
    await draw.event.load();
    final event = draw.event.value!;
    await event.players.load();
    
    return _getPlayerList(event, draw.minSessionNumber, draw.maxSessionNumber, draw.excludedPlayers, draw.requiredPlayers, draw.excludedSessions, draw.requiredSessions);
  }

  Future<void> calculateDraw(Draw draw) async {
    await _drawWinnerRepository.deleteAll(draw.winners.map((e) => e.id).toSet());
    await _drawRepository.save(draw);

    final players = await getPlayerList(draw);

    if(players.isEmpty) return;

    final winnerCount = min(draw.winnerCount, players.length);
    final List<DrawWinner> winners = [];

    for(int i = 0; i<winnerCount; i++){
      if(players.isEmpty) continue;
      final winner = getWinner(players);
      if(winner == null) continue;
      winners.add(DrawWinner.fromDraw(draw, winner, i+1));
      players.remove(winner);
    }

    await _drawWinnerRepository.saveAll(winners);
  }


  Player? getWinner(Set<Player> players){
    if(players.length == 1) return players.first;
    if(players.isEmpty) return null;

    final List<Player> lots = [];
    for (var p in players) {
      for(int t = 0;t < p.getTokenCount(); t++){
        lots.add(p);
      }
    }

    final tally = players.fold(0, (t, p) => t + p.getTokenCount());
    if(tally != lots.length) throw "WTF";

    final winnerLot = _random.nextInt(lots.length);
    return lots[winnerLot];
  }

}
