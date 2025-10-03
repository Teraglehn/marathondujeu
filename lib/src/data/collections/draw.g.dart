// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDrawCollection on Isar {
  IsarCollection<Draw> get draws => this.collection();
}

const DrawSchema = CollectionSchema(
  name: r'Draw',
  id: -3380831115710708004,
  properties: {
    r'maxSessionNumber': PropertySchema(
      id: 0,
      name: r'maxSessionNumber',
      type: IsarType.long,
    ),
    r'minSessionNumber': PropertySchema(
      id: 1,
      name: r'minSessionNumber',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'winnerCount': PropertySchema(
      id: 3,
      name: r'winnerCount',
      type: IsarType.long,
    )
  },
  estimateSize: _drawEstimateSize,
  serialize: _drawSerialize,
  deserialize: _drawDeserialize,
  deserializeProp: _drawDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'excludedSessions': LinkSchema(
      id: -1633543007239570293,
      name: r'excludedSessions',
      target: r'Session',
      single: false,
    ),
    r'requiredSessions': LinkSchema(
      id: 43045321013430685,
      name: r'requiredSessions',
      target: r'Session',
      single: false,
    ),
    r'excludedPlayers': LinkSchema(
      id: 1144827421084127932,
      name: r'excludedPlayers',
      target: r'Player',
      single: false,
    ),
    r'winners': LinkSchema(
      id: 8685496200736424818,
      name: r'winners',
      target: r'DrawWinner',
      single: false,
      linkName: r'draw',
    ),
    r'event': LinkSchema(
      id: 1869897891888667584,
      name: r'event',
      target: r'Event',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _drawGetId,
  getLinks: _drawGetLinks,
  attach: _drawAttach,
  version: '3.1.8',
);

int _drawEstimateSize(
  Draw object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _drawSerialize(
  Draw object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.maxSessionNumber);
  writer.writeLong(offsets[1], object.minSessionNumber);
  writer.writeString(offsets[2], object.name);
  writer.writeLong(offsets[3], object.winnerCount);
}

Draw _drawDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Draw();
  object.id = id;
  object.maxSessionNumber = reader.readLong(offsets[0]);
  object.minSessionNumber = reader.readLong(offsets[1]);
  object.name = reader.readString(offsets[2]);
  object.winnerCount = reader.readLong(offsets[3]);
  return object;
}

P _drawDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _drawGetId(Draw object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _drawGetLinks(Draw object) {
  return [
    object.excludedSessions,
    object.requiredSessions,
    object.excludedPlayers,
    object.winners,
    object.event
  ];
}

void _drawAttach(IsarCollection<dynamic> col, Id id, Draw object) {
  object.id = id;
  object.excludedSessions
      .attach(col, col.isar.collection<Session>(), r'excludedSessions', id);
  object.requiredSessions
      .attach(col, col.isar.collection<Session>(), r'requiredSessions', id);
  object.excludedPlayers
      .attach(col, col.isar.collection<Player>(), r'excludedPlayers', id);
  object.winners.attach(col, col.isar.collection<DrawWinner>(), r'winners', id);
  object.event.attach(col, col.isar.collection<Event>(), r'event', id);
}

extension DrawQueryWhereSort on QueryBuilder<Draw, Draw, QWhere> {
  QueryBuilder<Draw, Draw, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DrawQueryWhere on QueryBuilder<Draw, Draw, QWhereClause> {
  QueryBuilder<Draw, Draw, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Draw, Draw, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DrawQueryFilter on QueryBuilder<Draw, Draw, QFilterCondition> {
  QueryBuilder<Draw, Draw, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> maxSessionNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxSessionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> maxSessionNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxSessionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> maxSessionNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxSessionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> maxSessionNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxSessionNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> minSessionNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minSessionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> minSessionNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minSessionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> minSessionNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minSessionNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> minSessionNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minSessionNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnerCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winnerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnerCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'winnerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnerCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'winnerCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnerCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'winnerCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DrawQueryObject on QueryBuilder<Draw, Draw, QFilterCondition> {}

extension DrawQueryLinks on QueryBuilder<Draw, Draw, QFilterCondition> {
  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedSessions(
      FilterQuery<Session> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'excludedSessions');
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedSessionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedSessions', length, true, length, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedSessionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedSessions', 0, true, 0, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedSessionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedSessions', 0, false, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition>
      excludedSessionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedSessions', 0, true, length, include);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition>
      excludedSessionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'excludedSessions', length, include, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedSessionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'excludedSessions', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> requiredSessions(
      FilterQuery<Session> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'requiredSessions');
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> requiredSessionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredSessions', length, true, length, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> requiredSessionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredSessions', 0, true, 0, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> requiredSessionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredSessions', 0, false, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition>
      requiredSessionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'requiredSessions', 0, true, length, include);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition>
      requiredSessionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'requiredSessions', length, include, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> requiredSessionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'requiredSessions', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedPlayers(
      FilterQuery<Player> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'excludedPlayers');
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedPlayersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedPlayers', length, true, length, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedPlayersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedPlayers', 0, true, 0, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedPlayersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedPlayers', 0, false, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedPlayersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'excludedPlayers', 0, true, length, include);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition>
      excludedPlayersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'excludedPlayers', length, include, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedPlayersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'excludedPlayers', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winners(
      FilterQuery<DrawWinner> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'winners');
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'winners', length, true, length, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'winners', 0, true, 0, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'winners', 0, false, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'winners', 0, true, length, include);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'winners', length, include, 999999, true);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> winnersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'winners', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> event(FilterQuery<Event> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'event');
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> eventIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'event', 0, true, 0, true);
    });
  }
}

extension DrawQuerySortBy on QueryBuilder<Draw, Draw, QSortBy> {
  QueryBuilder<Draw, Draw, QAfterSortBy> sortByMaxSessionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxSessionNumber', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> sortByMaxSessionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxSessionNumber', Sort.desc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> sortByMinSessionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minSessionNumber', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> sortByMinSessionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minSessionNumber', Sort.desc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> sortByWinnerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerCount', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> sortByWinnerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerCount', Sort.desc);
    });
  }
}

extension DrawQuerySortThenBy on QueryBuilder<Draw, Draw, QSortThenBy> {
  QueryBuilder<Draw, Draw, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByMaxSessionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxSessionNumber', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByMaxSessionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxSessionNumber', Sort.desc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByMinSessionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minSessionNumber', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByMinSessionNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minSessionNumber', Sort.desc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByWinnerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerCount', Sort.asc);
    });
  }

  QueryBuilder<Draw, Draw, QAfterSortBy> thenByWinnerCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winnerCount', Sort.desc);
    });
  }
}

extension DrawQueryWhereDistinct on QueryBuilder<Draw, Draw, QDistinct> {
  QueryBuilder<Draw, Draw, QDistinct> distinctByMaxSessionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxSessionNumber');
    });
  }

  QueryBuilder<Draw, Draw, QDistinct> distinctByMinSessionNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minSessionNumber');
    });
  }

  QueryBuilder<Draw, Draw, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Draw, Draw, QDistinct> distinctByWinnerCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'winnerCount');
    });
  }
}

extension DrawQueryProperty on QueryBuilder<Draw, Draw, QQueryProperty> {
  QueryBuilder<Draw, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Draw, int, QQueryOperations> maxSessionNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxSessionNumber');
    });
  }

  QueryBuilder<Draw, int, QQueryOperations> minSessionNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minSessionNumber');
    });
  }

  QueryBuilder<Draw, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Draw, int, QQueryOperations> winnerCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'winnerCount');
    });
  }
}
