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
    r'backupPath': PropertySchema(
      id: 0,
      name: r'backupPath',
      type: IsarType.string,
    ),
    r'endDateTime': PropertySchema(
      id: 1,
      name: r'endDateTime',
      type: IsarType.dateTime,
    ),
    r'idBackgroundColor': PropertySchema(
      id: 2,
      name: r'idBackgroundColor',
      type: IsarType.long,
    ),
    r'idColor': PropertySchema(id: 3, name: r'idColor', type: IsarType.long),
    r'idFontSize': PropertySchema(
      id: 4,
      name: r'idFontSize',
      type: IsarType.long,
    ),
    r'idPadding': PropertySchema(
      id: 5,
      name: r'idPadding',
      type: IsarType.double,
    ),
    r'idPosX': PropertySchema(id: 6, name: r'idPosX', type: IsarType.double),
    r'idPosY': PropertySchema(id: 7, name: r'idPosY', type: IsarType.double),
    r'name': PropertySchema(id: 8, name: r'name', type: IsarType.string),
    r'pageBackgroundColor': PropertySchema(
      id: 9,
      name: r'pageBackgroundColor',
      type: IsarType.long,
    ),
    r'pageMargin': PropertySchema(
      id: 10,
      name: r'pageMargin',
      type: IsarType.double,
    ),
    r'playerCardBackgroundImage': PropertySchema(
      id: 11,
      name: r'playerCardBackgroundImage',
      type: IsarType.byteList,
    ),
    r'playerCardGapX': PropertySchema(
      id: 12,
      name: r'playerCardGapX',
      type: IsarType.double,
    ),
    r'playerCardGapY': PropertySchema(
      id: 13,
      name: r'playerCardGapY',
      type: IsarType.double,
    ),
    r'playerCardHeight': PropertySchema(
      id: 14,
      name: r'playerCardHeight',
      type: IsarType.long,
    ),
    r'playerCardLandscape': PropertySchema(
      id: 15,
      name: r'playerCardLandscape',
      type: IsarType.bool,
    ),
    r'playerCardRowsPerPage': PropertySchema(
      id: 16,
      name: r'playerCardRowsPerPage',
      type: IsarType.long,
    ),
    r'playerCardWidth': PropertySchema(
      id: 17,
      name: r'playerCardWidth',
      type: IsarType.double,
    ),
    r'playerCardsPerRow': PropertySchema(
      id: 18,
      name: r'playerCardsPerRow',
      type: IsarType.long,
    ),
    r'qrCodeBackgroundColor': PropertySchema(
      id: 19,
      name: r'qrCodeBackgroundColor',
      type: IsarType.long,
    ),
    r'qrCodePadding': PropertySchema(
      id: 20,
      name: r'qrCodePadding',
      type: IsarType.double,
    ),
    r'qrCodePosX': PropertySchema(
      id: 21,
      name: r'qrCodePosX',
      type: IsarType.double,
    ),
    r'qrCodePosY': PropertySchema(
      id: 22,
      name: r'qrCodePosY',
      type: IsarType.double,
    ),
    r'qrCodeSize': PropertySchema(
      id: 23,
      name: r'qrCodeSize',
      type: IsarType.double,
    ),
    r'qrSalt': PropertySchema(id: 24, name: r'qrSalt', type: IsarType.string),
    r'sessionIntervalMinutes': PropertySchema(
      id: 25,
      name: r'sessionIntervalMinutes',
      type: IsarType.long,
    ),
    r'sessionTimeMinutes': PropertySchema(
      id: 26,
      name: r'sessionTimeMinutes',
      type: IsarType.long,
    ),
    r'startDateTime': PropertySchema(
      id: 27,
      name: r'startDateTime',
      type: IsarType.dateTime,
    ),
    r'uid': PropertySchema(id: 28, name: r'uid', type: IsarType.string),
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
    ),
  },
  embeddedSchemas: {},

  getId: _eventGetId,
  getLinks: _eventGetLinks,
  attach: _eventAttach,
  version: '3.3.2',
);

int _eventEstimateSize(
  Event object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.backupPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.playerCardBackgroundImage;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  bytesCount += 3 + object.qrSalt.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _eventSerialize(
  Event object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.backupPath);
  writer.writeDateTime(offsets[1], object.endDateTime);
  writer.writeLong(offsets[2], object.idBackgroundColor);
  writer.writeLong(offsets[3], object.idColor);
  writer.writeLong(offsets[4], object.idFontSize);
  writer.writeDouble(offsets[5], object.idPadding);
  writer.writeDouble(offsets[6], object.idPosX);
  writer.writeDouble(offsets[7], object.idPosY);
  writer.writeString(offsets[8], object.name);
  writer.writeLong(offsets[9], object.pageBackgroundColor);
  writer.writeDouble(offsets[10], object.pageMargin);
  writer.writeByteList(offsets[11], object.playerCardBackgroundImage);
  writer.writeDouble(offsets[12], object.playerCardGapX);
  writer.writeDouble(offsets[13], object.playerCardGapY);
  writer.writeLong(offsets[14], object.playerCardHeight);
  writer.writeBool(offsets[15], object.playerCardLandscape);
  writer.writeLong(offsets[16], object.playerCardRowsPerPage);
  writer.writeDouble(offsets[17], object.playerCardWidth);
  writer.writeLong(offsets[18], object.playerCardsPerRow);
  writer.writeLong(offsets[19], object.qrCodeBackgroundColor);
  writer.writeDouble(offsets[20], object.qrCodePadding);
  writer.writeDouble(offsets[21], object.qrCodePosX);
  writer.writeDouble(offsets[22], object.qrCodePosY);
  writer.writeDouble(offsets[23], object.qrCodeSize);
  writer.writeString(offsets[24], object.qrSalt);
  writer.writeLong(offsets[25], object.sessionIntervalMinutes);
  writer.writeLong(offsets[26], object.sessionTimeMinutes);
  writer.writeDateTime(offsets[27], object.startDateTime);
  writer.writeString(offsets[28], object.uid);
}

Event _eventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Event();
  object.backupPath = reader.readStringOrNull(offsets[0]);
  object.endDateTime = reader.readDateTime(offsets[1]);
  object.id = id;
  object.idBackgroundColor = reader.readLongOrNull(offsets[2]);
  object.idColor = reader.readLong(offsets[3]);
  object.idFontSize = reader.readLong(offsets[4]);
  object.idPadding = reader.readDouble(offsets[5]);
  object.idPosX = reader.readDouble(offsets[6]);
  object.idPosY = reader.readDouble(offsets[7]);
  object.name = reader.readString(offsets[8]);
  object.pageBackgroundColor = reader.readLong(offsets[9]);
  object.pageMargin = reader.readDouble(offsets[10]);
  object.playerCardBackgroundImage = reader.readByteList(offsets[11]);
  object.playerCardGapX = reader.readDouble(offsets[12]);
  object.playerCardGapY = reader.readDouble(offsets[13]);
  object.playerCardHeight = reader.readLong(offsets[14]);
  object.playerCardLandscape = reader.readBool(offsets[15]);
  object.playerCardRowsPerPage = reader.readLong(offsets[16]);
  object.playerCardWidth = reader.readDouble(offsets[17]);
  object.playerCardsPerRow = reader.readLong(offsets[18]);
  object.qrCodeBackgroundColor = reader.readLongOrNull(offsets[19]);
  object.qrCodePadding = reader.readDouble(offsets[20]);
  object.qrCodePosX = reader.readDouble(offsets[21]);
  object.qrCodePosY = reader.readDouble(offsets[22]);
  object.qrCodeSize = reader.readDouble(offsets[23]);
  object.qrSalt = reader.readString(offsets[24]);
  object.sessionIntervalMinutes = reader.readLong(offsets[25]);
  object.sessionTimeMinutes = reader.readLong(offsets[26]);
  object.startDateTime = reader.readDateTime(offsets[27]);
  object.uid = reader.readString(offsets[28]);
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
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readByteList(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    case 18:
      return (reader.readLong(offset)) as P;
    case 19:
      return (reader.readLongOrNull(offset)) as P;
    case 20:
      return (reader.readDouble(offset)) as P;
    case 21:
      return (reader.readDouble(offset)) as P;
    case 22:
      return (reader.readDouble(offset)) as P;
    case 23:
      return (reader.readDouble(offset)) as P;
    case 24:
      return (reader.readString(offset)) as P;
    case 25:
      return (reader.readLong(offset)) as P;
    case 26:
      return (reader.readLong(offset)) as P;
    case 27:
      return (reader.readDateTime(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
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
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
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

  QueryBuilder<Event, Event, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
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
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension EventQueryFilter on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'backupPath'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'backupPath'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'backupPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'backupPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'backupPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'backupPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'backupPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'backupPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'backupPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'backupPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'backupPath', value: ''),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> backupPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'backupPath', value: ''),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endDateTime', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endDateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endDateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endDateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endDateTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idBackgroundColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'idBackgroundColor'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  idBackgroundColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'idBackgroundColor'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idBackgroundColorEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'idBackgroundColor', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  idBackgroundColorGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idBackgroundColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idBackgroundColorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idBackgroundColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idBackgroundColorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idBackgroundColor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idColorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'idColor', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idColor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idFontSizeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'idFontSize', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idFontSizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idFontSize',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idFontSizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idFontSize',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idFontSizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idFontSize',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPaddingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'idPadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPaddingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idPadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPaddingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idPadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPaddingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idPadding',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'idPosX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idPosX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idPosX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idPosX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'idPosY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'idPosY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'idPosY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idPosYBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'idPosY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
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
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> pageBackgroundColorEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pageBackgroundColor', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  pageBackgroundColorGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pageBackgroundColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> pageBackgroundColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pageBackgroundColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> pageBackgroundColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pageBackgroundColor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> pageMarginEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pageMargin',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> pageMarginGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pageMargin',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> pageMarginLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pageMargin',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> pageMarginBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pageMargin',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardBackgroundImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'playerCardBackgroundImage'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardBackgroundImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'playerCardBackgroundImage'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardBackgroundImageElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'playerCardBackgroundImage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardBackgroundImageElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerCardBackgroundImage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardBackgroundImageElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerCardBackgroundImage',
          value: value,
        ),
      );
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
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerCardBackgroundImage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
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
      return query.listLength(r'playerCardBackgroundImage', 0, true, 0, true);
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
  playerCardBackgroundImageLengthLessThan(int length, {bool include = false}) {
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

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'playerCardGapX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerCardGapX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerCardGapX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerCardGapX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapYEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'playerCardGapY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapYGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerCardGapY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapYLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerCardGapY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardGapYBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerCardGapY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'playerCardHeight', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerCardHeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerCardHeight',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardHeightBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerCardHeight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardLandscapeEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'playerCardLandscape', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardRowsPerPageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'playerCardRowsPerPage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardRowsPerPageGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerCardRowsPerPage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardRowsPerPageLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerCardRowsPerPage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardRowsPerPageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerCardRowsPerPage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'playerCardWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerCardWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerCardWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardWidthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerCardWidth',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardsPerRowEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'playerCardsPerRow', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  playerCardsPerRowGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerCardsPerRow',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardsPerRowLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerCardsPerRow',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playerCardsPerRowBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerCardsPerRow',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  qrCodeBackgroundColorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'qrCodeBackgroundColor'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  qrCodeBackgroundColorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'qrCodeBackgroundColor'),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  qrCodeBackgroundColorEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrCodeBackgroundColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  qrCodeBackgroundColorGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrCodeBackgroundColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  qrCodeBackgroundColorLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrCodeBackgroundColor',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  qrCodeBackgroundColorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrCodeBackgroundColor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePaddingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrCodePadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePaddingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrCodePadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePaddingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrCodePadding',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePaddingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrCodePadding',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrCodePosX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrCodePosX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrCodePosX',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrCodePosX',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrCodePosY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrCodePosY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrCodePosY',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodePosYBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrCodePosY',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrCodeSize',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrCodeSize',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrCodeSize',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrCodeSizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrCodeSize',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'qrSalt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'qrSalt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'qrSalt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
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
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'qrSalt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'qrSalt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'qrSalt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'qrSalt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'qrSalt',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'qrSalt', value: ''),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> qrSaltIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'qrSalt', value: ''),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  sessionIntervalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sessionIntervalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  sessionIntervalMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sessionIntervalMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  sessionIntervalMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sessionIntervalMinutes',
          value: value,
        ),
      );
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
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sessionIntervalMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionTimeMinutesEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sessionTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
  sessionTimeMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sessionTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionTimeMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sessionTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionTimeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sessionTimeMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startDateTime', value: value),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startDateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startDateTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startDateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startDateTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uid', value: ''),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uid', value: ''),
      );
    });
  }
}

extension EventQueryObject on QueryBuilder<Event, Event, QFilterCondition> {}

extension EventQueryLinks on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> players(
    FilterQuery<Player> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'players');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> playersLengthEqualTo(
    int length,
  ) {
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
        r'players',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessions(
    FilterQuery<Session> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sessions');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> sessionsLengthEqualTo(
    int length,
  ) {
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
        r'sessions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension EventQuerySortBy on QueryBuilder<Event, Event, QSortBy> {
  QueryBuilder<Event, Event, QAfterSortBy> sortByBackupPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupPath', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByBackupPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupPath', Sort.desc);
    });
  }

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

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idBackgroundColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdBackgroundColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idBackgroundColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idFontSize', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idFontSize', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPadding', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdPaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPadding', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> sortByPageBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageBackgroundColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPageBackgroundColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageBackgroundColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPageMargin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageMargin', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPageMarginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageMargin', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardGapX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapX', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardGapXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapX', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardGapY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapY', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardGapYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapY', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardLandscape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardLandscape', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardLandscapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardLandscape', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardRowsPerPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardRowsPerPage', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardRowsPerPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardRowsPerPage', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardsPerRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardsPerRow', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPlayerCardsPerRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardsPerRow', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodeBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeBackgroundColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodeBackgroundColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeBackgroundColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodePadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePadding', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByQrCodePaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePadding', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension EventQuerySortThenBy on QueryBuilder<Event, Event, QSortThenBy> {
  QueryBuilder<Event, Event, QAfterSortBy> thenByBackupPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupPath', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByBackupPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupPath', Sort.desc);
    });
  }

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

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idBackgroundColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdBackgroundColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idBackgroundColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idFontSize', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdFontSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idFontSize', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPadding', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdPaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idPadding', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> thenByPageBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageBackgroundColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPageBackgroundColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageBackgroundColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPageMargin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageMargin', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPageMarginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageMargin', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardGapX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapX', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardGapXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapX', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardGapY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapY', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardGapYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardGapY', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardLandscape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardLandscape', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardLandscapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardLandscape', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardRowsPerPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardRowsPerPage', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardRowsPerPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardRowsPerPage', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardsPerRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardsPerRow', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPlayerCardsPerRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerCardsPerRow', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodeBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeBackgroundColor', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodeBackgroundColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodeBackgroundColor', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodePadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePadding', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByQrCodePaddingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qrCodePadding', Sort.desc);
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

  QueryBuilder<Event, Event, QAfterSortBy> thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension EventQueryWhereDistinct on QueryBuilder<Event, Event, QDistinct> {
  QueryBuilder<Event, Event, QDistinct> distinctByBackupPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backupPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByEndDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDateTime');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIdBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idBackgroundColor');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIdColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idColor');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIdFontSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idFontSize');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIdPadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'idPadding');
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

  QueryBuilder<Event, Event, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPageBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageBackgroundColor');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPageMargin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageMargin');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardBackgroundImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardBackgroundImage');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardGapX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardGapX');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardGapY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardGapY');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardHeight');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardLandscape() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardLandscape');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardRowsPerPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardRowsPerPage');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardWidth');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPlayerCardsPerRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerCardsPerRow');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByQrCodeBackgroundColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrCodeBackgroundColor');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByQrCodePadding() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qrCodePadding');
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

  QueryBuilder<Event, Event, QDistinct> distinctByQrSalt({
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<Event, Event, QDistinct> distinctByUid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension EventQueryProperty on QueryBuilder<Event, Event, QQueryProperty> {
  QueryBuilder<Event, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Event, String?, QQueryOperations> backupPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backupPath');
    });
  }

  QueryBuilder<Event, DateTime, QQueryOperations> endDateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDateTime');
    });
  }

  QueryBuilder<Event, int?, QQueryOperations> idBackgroundColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idBackgroundColor');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> idColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idColor');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> idFontSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idFontSize');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> idPaddingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idPadding');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> idPosXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idPosX');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> idPosYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idPosY');
    });
  }

  QueryBuilder<Event, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> pageBackgroundColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageBackgroundColor');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> pageMarginProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageMargin');
    });
  }

  QueryBuilder<Event, List<int>?, QQueryOperations>
  playerCardBackgroundImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardBackgroundImage');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> playerCardGapXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardGapX');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> playerCardGapYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardGapY');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> playerCardHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardHeight');
    });
  }

  QueryBuilder<Event, bool, QQueryOperations> playerCardLandscapeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardLandscape');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> playerCardRowsPerPageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardRowsPerPage');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> playerCardWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardWidth');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> playerCardsPerRowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerCardsPerRow');
    });
  }

  QueryBuilder<Event, int?, QQueryOperations> qrCodeBackgroundColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodeBackgroundColor');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> qrCodePaddingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodePadding');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> qrCodePosXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodePosX');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> qrCodePosYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qrCodePosY');
    });
  }

  QueryBuilder<Event, double, QQueryOperations> qrCodeSizeProperty() {
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

  QueryBuilder<Event, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}
