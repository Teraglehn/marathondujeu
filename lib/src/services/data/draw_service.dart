import 'dart:math';

import 'package:marathondujeu/src/data/data.dart';

class DrawService {
  final DrawRepository _drawRepository;
  final DrawWinnerRepository _drawWinnerRepository;

  DrawService(this._drawRepository, this._drawWinnerRepository);

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

  Future<Set<Player>> getPlayerList(Draw draw) async {
    await draw.event.load();
    final event = draw.event.value!;
    await event.players.load();
    Set<Player> players = event.players.toSet();

    if(draw.minSessionNumber > 0){
      players.removeWhere((p) => p.getSessionNumber() < draw.minSessionNumber);
    }

    if(draw.maxSessionNumber > 0){
      players.removeWhere((p) => p.getSessionNumber() > draw.maxSessionNumber);
    }

    players.removeAll(draw.excludedPlayers);
    players.removeWhere((p) => p.sessions.intersection(draw.excludedSessions).isNotEmpty);
    players.removeWhere((p) => p.sessions.intersection(draw.requiredSessions).length < draw.requiredSessions.length);

    return players;
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
      final winner = _getWinner(players);
      if(winner == null) continue;
      winners.add(DrawWinner.fromDraw(draw, winner, i+1));
      players.remove(winner);
    }

    await _drawWinnerRepository.saveAll(winners);
  }


  Player? _getWinner(Set<Player> players){
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

    final rand = Random.secure();
    final winnerLot = rand.nextInt(lots.length);
    return lots[winnerLot];
  }

}
