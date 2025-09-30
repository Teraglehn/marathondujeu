// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventCollection on Isar {
  IsarCollection<Event> get events => this.collection();
}

const EventSchema = CollectionSchema(
  name: r'Event',
  id: 2102939193127251002,
  properties: {
    r'endDateTime': PropertySchema(
      id: 0,
      name: r'endDateTime',
      type: IsarType.dateTime,
    ),
    r'idPosX': PropertySchema(
      id: 1,
      name: r'idPosX',
      type: IsarType.long,
    ),
    r'idPosY': PropertySchema(
      id: 2,
      name: r'idPosY',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'playerCardBackgroundImage': PropertySchema(
      id: 4,
      name: r'playerCardBackgroundImage',
      type: IsarType.byteList,
    ),
    r'playerCardHeight': PropertySchema(
      id: 5,
      name: r'playerCardHeight',
      type: IsarType.long,
    ),
    r'playerCardWidth': PropertySchema(
      id: 6,
      name: r'playerCardWidth',
      type: IsarType.long,
    ),
    r'qrCodePosX': PropertySchema(
      id: 7,
      name: r'qrCodePosX',
      type: IsarType.long,
    ),
    r'qrCodePosY': PropertySchema(
      id: 8,
      name: r'qrCodePosY',
      type: IsarType.long,
    ),
    r'qrCodeSize': PropertySchema(
      id: 9,
      name: r'qrCodeSize',
      type: IsarType.long,
    ),
    r'qrSalt': PropertySchema(
      id: 10,
      name: r'qrSalt',
      type: IsarType.string,
    ),
    r'sessionIntervalMinutes': PropertySchema(
      id: 11,
      name: r'sessionIntervalMinutes',
      type: IsarType.long,
    ),
    r'sessionTimeMinutes': PropertySchema(
      id: 12,
      name: r'sessionTimeMinutes',
      type: IsarType.long,
    ),
    r'startDateTime': PropertySchema(
      id: 13,
      name: r'startDateTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _eventEstimateSize,
  serialize: _eventSerialize,
  deserialize: _eventDeserialize,
  deserializeProp: _eventDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'players': LinkSchema(
      id: -3573644783869504560,
      name: r'players',
      target: r'Player',
      single: false,
      linkName: r'event',
    ),
    r'sessions': LinkSchema(
      id: 4192683325109520066,
      name: r'sessions',
      target: r'Session',
      single: false,
      linkName: r'event',
    )
  },
  embeddedSchemas: {},
  getId: _eventGetId,
  getLinks: _eventGetLinks,
  attach: _eventAttach,
  version: '3.1.8',
);

int _eventEstimateSize(
  Event object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.playerCardBackgroundImage;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  bytesCount += 3 + object.qrSalt.length * 3;
  return bytesCount;
}

void _eventSerialize(
  Event object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.endDateTime);
  writer.writeLong(offsets[1], object.idPosX);
  writer.writeLong(offsets[2], object.idPosY);
  writer.writeString(offsets[3], object.name);
  writer.writeByteList(offsets[4], object.playerCardBackgroundImage);
  writer.writeLong(offsets[5], object.playerCardHeight);
  writer.writeLong(offsets[6], object.playerCardWidth);
  writer.writeLong(offsets[7], object.qrCodePosX);
  writer.writeLong(offsets[8], object.qrCodePosY);
  writer.writeLong(offsets[9], object.qrCodeSize);
  writer.writeString(offsets[10], object.qrSalt);
  writer.writeLong(offsets[11], object.sessionIntervalMinutes);
  writer.writeLong(offsets[12], object.sessionTimeMinutes);
  writer.writeDateTime(offsets[13], object.startDateTime);
}

Event _eventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Event();
  object.endDateTime = reader.readDateTime(offsets[0]);
  object.id = id;
  object.idPosX = reader.readLong(offsets[1]);
  object.idPosY = reader.readLong(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.playerCardBackgroundImage = reader.readByteList(offsets[4]);
  object.playerCardHeight = reader.readLong(offsets[5]);
  object.playerCardWidth = reader.readLong(offsets[6]);
  object.qrCodePosX = reader.readLong(offsets[7]);
  object.qrCodePosY = reader.readLong(offsets[8]);
  object.qrCodeSize = reader.readLong(offsets[9]);
  object.qrSalt = reader.readString(offsets[10]);
  object.sessionIntervalMinutes = reader.readLong(offsets[11]);
  object.sessionTimeMinutes = reader.readLong(offsets[12]);
  object.startDateTime = reader.readDateTime(offsets[13]);
  return object;
}

P _eventDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readByteList(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _eventGetId(Event object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _eventGetLinks(Event object) {
  return [object.players, object.sessions];
}

void _eventAttach(IsarCollection<dynamic> col, Id id, Event object) {
  object.id = id;
  object.players.attach(col, col.isar.collection<Player>(), r'players', id);
  object.sessions.attach(col, col.isar.collection<Session>(), r'sessions', id);
}

extension EventQueryWhereSort on QueryBuilder<Event, Event, QWhere> {
  QueryBuilder<Event, Event, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventQueryWhere on QueryBuilder<Event, Event, QWhereClause> {
  QueryBuilder<Event, Event, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Event, Event, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idBetween(
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

extension EventQueryFilter on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idPosX',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idPosX',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idPosX',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idPosX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idPosY',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idPosY',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idPosY',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idPosY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Event, Event, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'playerCardBackgroundImage',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'playerCardBackgroundImage',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerCardBackgroundImage',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerCardBackgroundImage',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerCardBackgroundImage',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerCardBackgroundImage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playerCardBackgroundImage',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playerCardBackgroundImage',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playerCardBackgroundImage',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playerCardBackgroundImage',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playerCardBackgroundImage',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      playerCardBackgroundImageLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'playerCardBackgroundImage',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerCardHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerCardHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerCardHeight',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerCardHeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playerCardWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playerCardWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playerCardWidth',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playerCardWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrCodePosX',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrCodePosX',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrCodePosX',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrCodePosX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrCodePosY',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrCodePosY',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrCodePosY',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrCodePosY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrCodeSize',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrCodeSize',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrCodeSize',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrCodeSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qrSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qrSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qrSalt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qrSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qrSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qrSalt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qrSalt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qrSalt',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qrSalt',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      sessionIntervalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionIntervalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      sessionIntervalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionIntervalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      sessionIntervalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionIntervalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      sessionIntervalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionIntervalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionTimeMinutesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      sessionTimeMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionTimeMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionTimeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionTimeMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EventQueryObject on QueryBuilder<Event, Event, QFilterCondition> {}

extension EventQueryLinks on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> players(
      FilterQuery<Player> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'players');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, true, length, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, false, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, length, include);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, include, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'players', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessions(
      FilterQuery<Session> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sessions');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', length, true, length, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', 0, true, 0, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', 0, false, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', 0, true, length, include);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sessions', length, include, 999999, true);
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'sessions', lower, includeLower, upper, includeUpper);
    });
  }
}

extension EventQuerySortBy on QueryBuilder<Event, Event, QSortBy> {
  QueryBuilder<Event, Event, QAfterSortBy> sortByEndDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByEndDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosX', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdPosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosX', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosY', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdPosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosY', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardHeight', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardHeight', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardWidth', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardWidth', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodePosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosX', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodePosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosX', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodePosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosY', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodePosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosY', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodeSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeSize', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodeSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeSize', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrSalt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrSalt', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrSaltDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrSalt', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortBySessionIntervalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionIntervalMinutes', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortBySessionIntervalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionIntervalMinutes', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortBySessionTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortBySessionTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.desc);
    });
  }
}

extension EventQuerySortThenBy on QueryBuilder<Event, Event, QSortThenBy> {
  QueryBuilder<Event, Event, QAfterSortBy> thenByEndDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByEndDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosX', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdPosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosX', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosY', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdPosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPosY', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardHeight', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardHeight', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardWidth', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardWidth', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodePosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosX', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodePosXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosX', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodePosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosY', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodePosYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePosY', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodeSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeSize', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodeSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeSize', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrSalt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrSalt', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrSaltDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrSalt', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenBySessionIntervalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionIntervalMinutes', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenBySessionIntervalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionIntervalMinutes', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenBySessionTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenBySessionTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDateTime', Sort.desc);
    });
  }
}

extension EventQueryWhereDistinct on QueryBuilder<Event, Event, QDistinct> {
  QueryBuilder<Event, Event, QDistinct> distinctByEndDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDateTime');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIdPosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idPosX');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIdPosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idPosY');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardBackgroundImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardBackgroundImage');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardHeight');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardWidth');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByQrCodePosX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrCodePosX');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByQrCodePosY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrCodePosY');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByQrCodeSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrCodeSize');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByQrSalt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrSalt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctBySessionIntervalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionIntervalMinutes');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctBySessionTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionTimeMinutes');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByStartDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDateTime');
    });
  }
}

extension EventQueryProperty on QueryBuilder<Event, Event, QQueryProperty> {
  QueryBuilder<Event, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Event, DateTime, QQueryOperations> endDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDateTime');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> idPosXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idPosX');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> idPosYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idPosY');
    });
  }

  QueryBuilder<Event, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Event, List<int>?, QQueryOperations>
      playerCardBackgroundImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardBackgroundImage');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> playerCardHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardHeight');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> playerCardWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardWidth');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> qrCodePosXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodePosX');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> qrCodePosYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodePosY');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> qrCodeSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodeSize');
    });
  }

  QueryBuilder<Event, String, QQueryOperations> qrSaltProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrSalt');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> sessionIntervalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionIntervalMinutes');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> sessionTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionTimeMinutes');
    });
  }

  QueryBuilder<Event, DateTime, QQueryOperations> startDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDateTime');
    });
  }
}
