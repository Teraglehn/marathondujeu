import 'dart:convert';

import 'package:marathondujeu/src/data/data.dart';

/// Tout ce qu'un événement contient, hors base : l'objet et ce qui s'y rattache, avec les
/// relations posées en mémoire (liens Isar non enregistrés). C'est ce que le fichier de
/// sauvegarde porte, dans les deux sens (L09).
class EventBackup {
  final Event event;
  final List<Player> players;
  final List<Session> sessions;
  final List<PlayerGroup> groups;
  final List<Draw> draws;
  /// Les gagnants, par tirage (même rang que [draws]), dans l'ordre des positions.
  final List<List<DrawWinner>> winners;

  const EventBackup({
    required this.event,
    required this.players,
    required this.sessions,
    required this.groups,
    required this.draws,
    required this.winners,
  });
}

/// Un fichier de sauvegarde illisible : pas du JSON, version inconnue, champ manquant.
class BackupFormatException implements Exception {
  final String message;
  const BackupFormatException(this.message);
  @override
  String toString() => message;
}

/// Le format du fichier de sauvegarde : un document JSON, version [version]. Aucun `id` Isar
/// dedans — les joueurs et les sessions sont cités par **numéro**, les groupes par leur **rang**
/// dans le tableau du fichier ; l'image de fond en base64. Lu et écrit par le même code : ce
/// qui n'est pas ici n'est pas sauvegardé.
class BackupFormat {
  static const int version = 1;

  BackupFormat._();

  // ------------------------------------------------------------------ écriture

  /// [backup] a ses liens **chargés** (`load()`) : le format ne touche pas la base.
  static String encode(EventBackup backup) {
    final e = backup.event;
    final json = {
      'format': version,
      'event': {
        'uid': e.uid,
        'name': e.name,
        'startDateTime': e.startDateTime.toIso8601String(),
        'endDateTime': e.endDateTime.toIso8601String(),
        'sessionTimeMinutes': e.sessionTimeMinutes,
        'sessionIntervalMinutes': e.sessionIntervalMinutes,
        'qrSalt': e.qrSalt,
        'playerCardHeight': e.playerCardHeight,
        'playerCardWidth': e.playerCardWidth,
        'playerCardBackgroundImage': e.playerCardBackgroundImage == null ? null : base64Encode(e.playerCardBackgroundImage!),
        'qrCodeSize': e.qrCodeSize,
        'qrCodePosX': e.qrCodePosX,
        'qrCodePosY': e.qrCodePosY,
        'idPosX': e.idPosX,
        'idPosY': e.idPosY,
        'playerCardsPerRow': e.playerCardsPerRow,
        'playerCardRowsPerPage': e.playerCardRowsPerPage,
        'playerCardLandscape': e.playerCardLandscape,
        'playerCardGapX': e.playerCardGapX,
        'playerCardGapY': e.playerCardGapY,
        'pageMargin': e.pageMargin,
        'pageBackgroundColor': e.pageBackgroundColor,
        'qrCodePadding': e.qrCodePadding,
        'qrCodeBackgroundColor': e.qrCodeBackgroundColor,
        'idFontSize': e.idFontSize,
        'idColor': e.idColor,
        'idPadding': e.idPadding,
        'idBackgroundColor': e.idBackgroundColor,
      },
      'players': [
        for (final p in backup.players)
          {'number': p.number, 'name': p.name, 'qrcode': p.qrcode, 'bonusSession': p.bonusSession},
      ],
      'sessions': [
        for (final s in backup.sessions)
          {
            'number': s.number,
            'startTime': s.startTime.toIso8601String(),
            'endTime': s.endTime.toIso8601String(),
            'players': _numbers(s.players),
          },
      ],
      'groups': [
        for (final g in backup.groups)
          {'name': g.name, 'kind': g.kind.name, 'players': _numbers(g.players)},
      ],
      'draws': [
        for (final (i, d) in backup.draws.indexed)
          {
            'number': d.number,
            'name': d.name,
            'minSessionNumber': d.minSessionNumber,
            'maxSessionNumber': d.maxSessionNumber,
            'winnerCount': d.winnerCount,
            'drawnAt': d.drawnAt?.toIso8601String(),
            'excludedSessions': _sessionNumbers(d.excludedSessions),
            'requiredSessions': _sessionNumbers(d.requiredSessions),
            'excludedGroups': _ranks(backup.groups, d.excludedGroups),
            'requiredGroups': _ranks(backup.groups, d.requiredGroups),
            'excludedPlayers': _numbers(d.excludedPlayers),
            'requiredPlayers': _numbers(d.requiredPlayers),
            'winnersGroup': d.winnersGroup.value == null ? null : backup.groups.indexOf(d.winnersGroup.value!),
            'winners': [
              for (final w in backup.winners[i]) {'position': w.position, 'number': w.winner.value!.number},
            ],
          },
      ],
    };
    return const JsonEncoder.withIndent('  ').convert(json);
  }

  static List<int> _numbers(Iterable<Player> players) => (players.map((p) => p.number).toList()..sort());
  static List<int> _sessionNumbers(Iterable<Session> sessions) => (sessions.map((s) => s.number).toList()..sort());
  static List<int> _ranks(List<PlayerGroup> groups, Iterable<PlayerGroup> chosen) =>
    (chosen.map((g) => groups.indexOf(g)).where((i) => i >= 0).toList()..sort());

  // ------------------------------------------------------------------ lecture

  /// Les objets d'un fichier, non enregistrés, reliés en mémoire. Lève [BackupFormatException]
  /// pour un contenu qui n'est pas un fichier de sauvegarde lisible.
  static EventBackup decode(String text) {
    final Object? root;
    try {
      root = jsonDecode(text);
    } on FormatException {
      throw const BackupFormatException('not json');
    }
    if (root is! Map<String, dynamic>) throw const BackupFormatException('not an object');
    final format = root['format'];
    if (format != version) throw BackupFormatException('unknown format $format');

    try {
      final e = _map(root, 'event');
      final event = Event()
        ..uid = _string(e, 'uid')
        ..name = _string(e, 'name')
        ..startDateTime = _date(e, 'startDateTime')
        ..endDateTime = _date(e, 'endDateTime')
        ..sessionTimeMinutes = _int(e, 'sessionTimeMinutes')
        ..sessionIntervalMinutes = _int(e, 'sessionIntervalMinutes')
        ..qrSalt = _string(e, 'qrSalt')
        ..playerCardHeight = _int(e, 'playerCardHeight')
        ..playerCardWidth = _double(e, 'playerCardWidth')
        ..playerCardBackgroundImage = e['playerCardBackgroundImage'] == null ? null : base64Decode(e['playerCardBackgroundImage'] as String)
        ..qrCodeSize = _double(e, 'qrCodeSize')
        ..qrCodePosX = _double(e, 'qrCodePosX')
        ..qrCodePosY = _double(e, 'qrCodePosY')
        ..idPosX = _double(e, 'idPosX')
        ..idPosY = _double(e, 'idPosY')
        ..playerCardsPerRow = _int(e, 'playerCardsPerRow')
        ..playerCardRowsPerPage = _int(e, 'playerCardRowsPerPage')
        ..playerCardLandscape = e['playerCardLandscape'] as bool
        ..playerCardGapX = _double(e, 'playerCardGapX')
        ..playerCardGapY = _double(e, 'playerCardGapY')
        ..pageMargin = _double(e, 'pageMargin')
        ..pageBackgroundColor = _int(e, 'pageBackgroundColor')
        ..qrCodePadding = _double(e, 'qrCodePadding')
        ..qrCodeBackgroundColor = e['qrCodeBackgroundColor'] as int?
        ..idFontSize = _int(e, 'idFontSize')
        ..idColor = _int(e, 'idColor')
        ..idPadding = _double(e, 'idPadding')
        ..idBackgroundColor = e['idBackgroundColor'] as int?;

      final players = [
        for (final p in _list(root, 'players'))
          Player()
            ..number = _int(p, 'number')
            ..name = _string(p, 'name')
            ..qrcode = _string(p, 'qrcode')
            ..bonusSession = _int(p, 'bonusSession')
            ..event.value = event,
      ];
      final byNumber = {for (final p in players) p.number: p};
      List<Player> playersOf(Map<String, dynamic> m, String key) =>
        [for (final n in _list(m, key)) byNumber[n as int] ?? (throw BackupFormatException('unknown player $n'))];

      final sessions = [
        for (final s in _list(root, 'sessions'))
          Session()
            ..number = _int(s, 'number')
            ..startTime = _date(s, 'startTime')
            ..endTime = _date(s, 'endTime')
            ..event.value = event
            ..players.addAll(playersOf(s, 'players')),
      ];
      final sessionByNumber = {for (final s in sessions) s.number: s};
      List<Session> sessionsOf(Map<String, dynamic> m, String key) =>
        [for (final n in _list(m, key)) sessionByNumber[n as int] ?? (throw BackupFormatException('unknown session $n'))];

      final groups = [
        for (final g in _list(root, 'groups'))
          PlayerGroup()
            ..name = _string(g, 'name')
            ..kind = PlayerGroupKind.values.byName(_string(g, 'kind'))
            ..event.value = event
            ..players.addAll(playersOf(g, 'players')),
      ];
      List<PlayerGroup> groupsOf(Map<String, dynamic> m, String key) => [for (final i in _list(m, key)) groups[i as int]];

      final draws = <Draw>[];
      final winners = <List<DrawWinner>>[];
      for (final (i, d) in _list(root, 'draws').indexed) {
        // Un fichier d'avant L21 n'a pas de numéro : le rang fait foi.
        final draw = Draw()
          ..number = (d['number'] as int?) ?? i + 1
          ..name = _string(d, 'name')
          ..minSessionNumber = _int(d, 'minSessionNumber')
          ..maxSessionNumber = _int(d, 'maxSessionNumber')
          ..winnerCount = _int(d, 'winnerCount')
          ..drawnAt = d['drawnAt'] == null ? null : DateTime.parse(d['drawnAt'] as String)
          ..event.value = event
          ..excludedSessions.addAll(sessionsOf(d, 'excludedSessions'))
          ..requiredSessions.addAll(sessionsOf(d, 'requiredSessions'))
          ..excludedGroups.addAll(groupsOf(d, 'excludedGroups'))
          ..requiredGroups.addAll(groupsOf(d, 'requiredGroups'))
          ..excludedPlayers.addAll(playersOf(d, 'excludedPlayers'))
          ..requiredPlayers.addAll(playersOf(d, 'requiredPlayers'))
          ..winnersGroup.value = d['winnersGroup'] == null ? null : groups[d['winnersGroup'] as int];
        draws.add(draw);
        winners.add([
          for (final w in _list(d, 'winners'))
            DrawWinner()
              ..position = _int(w, 'position')
              ..draw.value = draw
              ..winner.value = byNumber[_int(w, 'number')] ?? (throw BackupFormatException('unknown player ${w['number']}')),
        ]);
      }

      return EventBackup(event: event, players: players, sessions: sessions, groups: groups, draws: draws, winners: winners);
    } on BackupFormatException {
      rethrow;
    } catch (e) {
      // Champ manquant, type inattendu, rang hors du tableau : un fichier qui n'est pas le nôtre.
      throw BackupFormatException(e.toString());
    }
  }

  static Map<String, dynamic> _map(Map<String, dynamic> m, String key) => m[key] as Map<String, dynamic>;
  static List<dynamic> _list(Map<String, dynamic> m, String key) => m[key] as List<dynamic>;
  static String _string(Map<String, dynamic> m, String key) => m[key] as String;
  static int _int(Map<String, dynamic> m, String key) => m[key] as int;
  static double _double(Map<String, dynamic> m, String key) => (m[key] as num).toDouble();
  static DateTime _date(Map<String, dynamic> m, String key) => DateTime.parse(m[key] as String);
}
