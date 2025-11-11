// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_checkin_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyCheckinDbCollection on Isar {
  IsarCollection<DailyCheckinDb> get dailyCheckinDbs => this.collection();
}

const DailyCheckinDbSchema = CollectionSchema(
  name: r'DailyCheckinDb',
  id: -4147162314219724692,
  properties: {
    r'checkinDate': PropertySchema(
      id: 0,
      name: r'checkinDate',
      type: IsarType.dateTime,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _dailyCheckinDbEstimateSize,
  serialize: _dailyCheckinDbSerialize,
  deserialize: _dailyCheckinDbDeserialize,
  deserializeProp: _dailyCheckinDbDeserializeProp,
  idName: r'id',
  indexes: {
    r'checkinDate': IndexSchema(
      id: -681195849625738402,
      name: r'checkinDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'checkinDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _dailyCheckinDbGetId,
  getLinks: _dailyCheckinDbGetLinks,
  attach: _dailyCheckinDbAttach,
  version: '3.3.0-dev.3',
);

int _dailyCheckinDbEstimateSize(
  DailyCheckinDb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dailyCheckinDbSerialize(
  DailyCheckinDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.checkinDate);
  writer.writeDateTime(offsets[1], object.createdAt);
}

DailyCheckinDb _dailyCheckinDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyCheckinDb();
  object.checkinDate = reader.readDateTime(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  return object;
}

P _dailyCheckinDbDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyCheckinDbGetId(DailyCheckinDb object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyCheckinDbGetLinks(DailyCheckinDb object) {
  return [];
}

void _dailyCheckinDbAttach(
  IsarCollection<dynamic> col,
  Id id,
  DailyCheckinDb object,
) {
  object.id = id;
}

extension DailyCheckinDbQueryWhereSort
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QWhere> {
  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhere> anyCheckinDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'checkinDate'),
      );
    });
  }
}

extension DailyCheckinDbQueryWhere
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QWhereClause> {
  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause> idBetween(
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

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause>
  checkinDateEqualTo(DateTime checkinDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'checkinDate',
          value: [checkinDate],
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause>
  checkinDateNotEqualTo(DateTime checkinDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkinDate',
                lower: [],
                upper: [checkinDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkinDate',
                lower: [checkinDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkinDate',
                lower: [checkinDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkinDate',
                lower: [],
                upper: [checkinDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause>
  checkinDateGreaterThan(DateTime checkinDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checkinDate',
          lower: [checkinDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause>
  checkinDateLessThan(DateTime checkinDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checkinDate',
          lower: [],
          upper: [checkinDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterWhereClause>
  checkinDateBetween(
    DateTime lowerCheckinDate,
    DateTime upperCheckinDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checkinDate',
          lower: [lowerCheckinDate],
          includeLower: includeLower,
          upper: [upperCheckinDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DailyCheckinDbQueryFilter
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QFilterCondition> {
  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  checkinDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'checkinDate', value: value),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  checkinDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'checkinDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  checkinDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'checkinDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  checkinDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'checkinDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterFilterCondition> idBetween(
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
}

extension DailyCheckinDbQueryObject
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QFilterCondition> {}

extension DailyCheckinDbQueryLinks
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QFilterCondition> {}

extension DailyCheckinDbQuerySortBy
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QSortBy> {
  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy>
  sortByCheckinDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkinDate', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy>
  sortByCheckinDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkinDate', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }
}

extension DailyCheckinDbQuerySortThenBy
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QSortThenBy> {
  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy>
  thenByCheckinDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkinDate', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy>
  thenByCheckinDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkinDate', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DailyCheckinDbQueryWhereDistinct
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QDistinct> {
  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QDistinct>
  distinctByCheckinDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checkinDate');
    });
  }

  QueryBuilder<DailyCheckinDb, DailyCheckinDb, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }
}

extension DailyCheckinDbQueryProperty
    on QueryBuilder<DailyCheckinDb, DailyCheckinDb, QQueryProperty> {
  QueryBuilder<DailyCheckinDb, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyCheckinDb, DateTime, QQueryOperations>
  checkinDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checkinDate');
    });
  }

  QueryBuilder<DailyCheckinDb, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }
}
