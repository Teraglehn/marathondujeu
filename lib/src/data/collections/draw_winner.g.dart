// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw_winner.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDrawWinnerCollection on Isar {
  IsarCollection<DrawWinner> get drawWinners => this.collection();
}

const DrawWinnerSchema = CollectionSchema(
  name: r'DrawWinner',
  id: 766793821209802962,
  properties: {
    r'position': PropertySchema(id: 0, name: r'position', type: IsarType.long),
  },

  estimateSize: _drawWinnerEstimateSize,
  serialize: _drawWinnerSerialize,
  deserialize: _drawWinnerDeserialize,
  deserializeProp: _drawWinnerDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'draw': LinkSchema(
      id: 4926871219691960904,
      name: r'draw',
      target: r'Draw',
      single: true,
    ),
    r'winner': LinkSchema(
      id: 7723278074270684308,
      name: r'winner',
      target: r'Player',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _drawWinnerGetId,
  getLinks: _drawWinnerGetLinks,
  attach: _drawWinnerAttach,
  version: '3.3.2',
);

int _drawWinnerEstimateSize(
  DrawWinner object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _drawWinnerSerialize(
  DrawWinner object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.position);
}

DrawWinner _drawWinnerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DrawWinner();
  object.id = id;
  object.position = reader.readLong(offsets[0]);
  return object;
}

P _drawWinnerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _drawWinnerGetId(DrawWinner object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _drawWinnerGetLinks(DrawWinner object) {
  return [object.draw, object.winner];
}

void _drawWinnerAttach(IsarCollection<dynamic> col, Id id, DrawWinner object) {
  object.id = id;
  object.draw.attach(col, col.isar.collection<Draw>(), r'draw', id);
  object.winner.attach(col, col.isar.collection<Player>(), r'winner', id);
}

extension DrawWinnerQueryWhereSort
    on QueryBuilder<DrawWinner, DrawWinner, QWhere> {
  QueryBuilder<DrawWinner, DrawWinner, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DrawWinnerQueryWhere
    on QueryBuilder<DrawWinner, DrawWinner, QWhereClause> {
  QueryBuilder<DrawWinner, DrawWinner, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DrawWinner, DrawWinner, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterWhereClause> idBetween(
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

extension DrawWinnerQueryFilter
    on QueryBuilder<DrawWinner, DrawWinner, QFilterCondition> {
  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> positionEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'position', value: value),
      );
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition>
  positionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'position',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> positionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'position',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'position',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DrawWinnerQueryObject
    on QueryBuilder<DrawWinner, DrawWinner, QFilterCondition> {}

extension DrawWinnerQueryLinks
    on QueryBuilder<DrawWinner, DrawWinner, QFilterCondition> {
  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> draw(
    FilterQuery<Draw> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'draw');
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> drawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'draw', 0, true, 0, true);
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> winner(
    FilterQuery<Player> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'winner');
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterFilterCondition> winnerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'winner', 0, true, 0, true);
    });
  }
}

extension DrawWinnerQuerySortBy
    on QueryBuilder<DrawWinner, DrawWinner, QSortBy> {
  QueryBuilder<DrawWinner, DrawWinner, QAfterSortBy> sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterSortBy> sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }
}

extension DrawWinnerQuerySortThenBy
    on QueryBuilder<DrawWinner, DrawWinner, QSortThenBy> {
  QueryBuilder<DrawWinner, DrawWinner, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterSortBy> thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<DrawWinner, DrawWinner, QAfterSortBy> thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }
}

extension DrawWinnerQueryWhereDistinct
    on QueryBuilder<DrawWinner, DrawWinner, QDistinct> {
  QueryBuilder<DrawWinner, DrawWinner, QDistinct> distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }
}

extension DrawWinnerQueryProperty
    on QueryBuilder<DrawWinner, DrawWinner, QQueryProperty> {
  QueryBuilder<DrawWinner, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DrawWinner, int, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }
}
