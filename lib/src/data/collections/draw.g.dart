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
    r'excluded': PropertySchema(
      id: 0,
      name: r'excluded',
      type: IsarType.stringList,
    ),
    r'results': PropertySchema(
      id: 1,
      name: r'results',
      type: IsarType.stringList,
    )
  },
  estimateSize: _drawEstimateSize,
  serialize: _drawSerialize,
  deserialize: _drawDeserialize,
  deserializeProp: _drawDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
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
  bytesCount += 3 + object.excluded.length * 3;
  {
    for (var i = 0; i < object.excluded.length; i++) {
      final value = object.excluded[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.results.length * 3;
  {
    for (var i = 0; i < object.results.length; i++) {
      final value = object.results[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _drawSerialize(
  Draw object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.excluded);
  writer.writeStringList(offsets[1], object.results);
}

Draw _drawDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Draw();
  object.id = id;
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
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _drawGetId(Draw object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _drawGetLinks(Draw object) {
  return [];
}

void _drawAttach(IsarCollection<dynamic> col, Id id, Draw object) {
  object.id = id;
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
  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'excluded',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'excluded',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'excluded',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'excluded',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'excluded',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'excluded',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'excluded',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'excluded',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'excluded',
        value: '',
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'excluded',
        value: '',
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'excluded',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'excluded',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'excluded',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'excluded',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'excluded',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> excludedLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'excluded',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

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

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'results',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'results',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'results',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'results',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'results',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'results',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'results',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'results',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'results',
        value: '',
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'results',
        value: '',
      ));
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Draw, Draw, QAfterFilterCondition> resultsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'results',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension DrawQueryObject on QueryBuilder<Draw, Draw, QFilterCondition> {}

extension DrawQueryLinks on QueryBuilder<Draw, Draw, QFilterCondition> {}

extension DrawQuerySortBy on QueryBuilder<Draw, Draw, QSortBy> {}

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
}

extension DrawQueryWhereDistinct on QueryBuilder<Draw, Draw, QDistinct> {
  QueryBuilder<Draw, Draw, QDistinct> distinctByExcluded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'excluded');
    });
  }

  QueryBuilder<Draw, Draw, QDistinct> distinctByResults() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'results');
    });
  }
}

extension DrawQueryProperty on QueryBuilder<Draw, Draw, QQueryProperty> {
  QueryBuilder<Draw, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Draw, List<String>, QQueryOperations> excludedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'excluded');
    });
  }

  QueryBuilder<Draw, List<String>, QQueryOperations> resultsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'results');
    });
  }
}
