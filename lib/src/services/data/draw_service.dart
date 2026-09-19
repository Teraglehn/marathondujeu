import 'dart:math';

import 'package:marathondujeu/src/data/data.dart';

class DrawService {
  final DrawRepository _drawRepository;
  final DrawWinnerRepository _drawWinnerRepository;
  final PlayerGroupRepository _playerGroupRepository;
  final Random _random;

  DrawService(this._drawRepository, this._drawWinnerRepository, this._playerGroupRepository, {Random? random})
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

  /// Combien de tirages, préparés ou effectués, tiennent ce groupe parmi leurs groupes exclus
  /// ou requis : tant qu'il y en a, le groupe ne se supprime pas (L16).
  Future<int> countUsingGroup(PlayerGroup group) async {
    return await _drawRepository.countUsingGroup(group.id);
  }

  /// Le nom par défaut d'un tirage : « Tirage N°n », n = plus grand identifiant + 1.
  Future<String> nextName() async {
    final draws = await _drawRepository.getAll();
    final maxId = draws.fold(0, (m, d) => d.id > m ? d.id : m);
    return 'Tirage N°${maxId + 1}';
  }

  /// Un tirage neuf, en mémoire, avec ses défauts : nom, et la dernière session requise —
  /// celle qui vient de se jouer.
  Future<Draw> createDraw(Event event) async {
    await event.sessions.load();
    final draw = Draw.empty()
      ..name = await nextName()
      ..event.value = event;
    if (event.sessions.isNotEmpty) {
      draw.requiredSessions.add(event.sessions.reduce((a, b) => a.startTime.isAfter(b.startTime) ? a : b));
    }
    return draw;
  }

  /// Copie un tirage : tout son paramétrage, plus le groupe de ses gagnants parmi les groupes exclus.
  /// La copie n'est pas enregistrée : c'est à l'éditeur de le faire.
  Future<Draw> createDrawFromDraw(Draw previousDraw) async {
    await Future.wait([
      previousDraw.event.load(),
      previousDraw.excludedPlayers.load(),
      previousDraw.requiredPlayers.load(),
      previousDraw.excludedSessions.load(),
      previousDraw.requiredSessions.load(),
      previousDraw.excludedGroups.load(),
      previousDraw.requiredGroups.load(),
      previousDraw.winnersGroup.load(),
    ]);

    final nextDraw = Draw.empty()
      ..name = await nextName()
      ..minSessionNumber = previousDraw.minSessionNumber
      ..maxSessionNumber = previousDraw.maxSessionNumber
      ..winnerCount = previousDraw.winnerCount
      ..excludedPlayers.addAll(previousDraw.excludedPlayers)
      ..requiredPlayers.addAll(previousDraw.requiredPlayers)
      ..excludedSessions.addAll(previousDraw.excludedSessions)
      ..requiredSessions.addAll(previousDraw.requiredSessions)
      ..excludedGroups.addAll(previousDraw.excludedGroups)
      ..requiredGroups.addAll(previousDraw.requiredGroups)
      ..event.value = previousDraw.event.value;

    // Les gagnants de la source sont exclus par leur groupe.
    if (previousDraw.winnersGroup.value != null) {
      nextDraw.excludedGroups.add(previousDraw.winnersGroup.value!);
    }

    return nextDraw;
  }

  /// Les joueurs d'un ensemble de groupes, chargés.
  Future<Set<Player>> _playersOfGroups(Iterable<PlayerGroup> groups) async {
    final players = <Player>{};
    for (final g in groups) {
      await g.players.load();
      players.addAll(g.players);
    }
    return players;
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
    // Sans jeton, aucune chance : le joueur n'est pas dans l'urne.
    players.removeWhere((p) => p.getTokenCount() <= 0);

    return players;
  }

  /// Les joueurs éligibles : les groupes sont résolus maintenant, pas à la préparation.
  Future<Set<Player>> getPlayerList(Draw draw) async {
    await draw.event.load();
    final event = draw.event.value!;
    await event.players.load();
    final excluded = {...draw.excludedPlayers, ...await _playersOfGroups(draw.excludedGroups)};
    final required = {...draw.requiredPlayers, ...await _playersOfGroups(draw.requiredGroups)};

    return _getPlayerList(event, draw.minSessionNumber, draw.maxSessionNumber, excluded, required, draw.excludedSessions, draw.requiredSessions);
  }

  /// Joueurs éligibles et jetons dans l'urne, depuis les choix de l'éditeur, avant enregistrement.
  Future<({int players, int tokens})> getEligibilityFor(Event event, {required int minSessionNumber, required int maxSessionNumber, required Set<Player> excludedPlayers, required Set<Player> requiredPlayers, required Set<PlayerGroup> excludedGroups, required Set<PlayerGroup> requiredGroups, required Set<Session> excludedSessions, required Set<Session> requiredSessions}) async {
    await event.players.load();
    final excluded = {...excludedPlayers, ...await _playersOfGroups(excludedGroups)};
    final required = {...requiredPlayers, ...await _playersOfGroups(requiredGroups)};
    final players = _getPlayerList(event, minSessionNumber, maxSessionNumber, excluded, required, excludedSessions, requiredSessions);
    return (players: players.length, tokens: players.fold(0, (sum, p) => sum + p.getTokenCount()));
  }

  /// Enregistre puis lance le tirage.
  Future<void> launch(Draw draw) async {
    await save(draw);
    await calculateDraw(draw);
  }

  /// Lance le tirage — une seule fois : un tirage déjà daté est refusé.
  Future<void> calculateDraw(Draw draw) async {
    if (draw.isDrawn) {
      throw StateError('Tirage déjà effectué : ${draw.name}');
    }
    final players = await getPlayerList(draw);
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

    // Les gagnants forment un groupe : lisible dans les groupes, exclu par une copie du tirage.
    if (winners.isNotEmpty) {
      final group = PlayerGroup.empty()
        ..name = 'Gagnants du tirage « ${draw.name} »'
        ..kind = PlayerGroupKind.winners
        ..event.value = draw.event.value;
      group.players.addAll(winners.map((w) => w.winner.value!));
      await _playerGroupRepository.save(group);
      draw.winnersGroup.value = group;
    }
    // Daté en dernier : la liste des tirages écoute cette collection, et doit voir les gagnants
    // déjà écrits quand elle se recharge.
    draw.drawnAt = DateTime.now();
    await _drawRepository.save(draw);
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
    // Personne n'a de jeton : pas de gagnant, plutôt qu'un tirage dans une urne vide.
    if (lots.isEmpty) return null;

    final winnerLot = _random.nextInt(lots.length);
    return lots[winnerLot];
  }

}
