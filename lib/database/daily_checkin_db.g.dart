// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_checkin_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyCheckInDbCollection on Isar {
  IsarCollection<DailyCheckInDb> get dailyCheckInDbs => this.collection();
}

const DailyCheckInDbSchema = CollectionSchema(
  name: r'DailyCheckInDb',
  id: 5747507820580413409,
  properties: {
    r'checkInDate': PropertySchema(
      id: 0,
      name: r'checkInDate',
      type: IsarType.dateTime,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _dailyCheckInDbEstimateSize,
  serialize: _dailyCheckInDbSerialize,
  deserialize: _dailyCheckInDbDeserialize,
  deserializeProp: _dailyCheckInDbDeserializeProp,
  idName: r'id',
  indexes: {
    r'checkInDate': IndexSchema(
      id: -2653265930173368932,
      name: r'checkInDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'checkInDate',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _dailyCheckInDbGetId,
  getLinks: _dailyCheckInDbGetLinks,
  attach: _dailyCheckInDbAttach,
  version: '3.3.0-dev.3',
);

int _dailyCheckInDbEstimateSize(
  DailyCheckInDb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dailyCheckInDbSerialize(
  DailyCheckInDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.checkInDate);
  writer.writeDateTime(offsets[1], object.createdAt);
}

DailyCheckInDb _dailyCheckInDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyCheckInDb();
  object.checkInDate = reader.readDateTime(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  return object;
}

P _dailyCheckInDbDeserializeProp<P>(
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

Id _dailyCheckInDbGetId(DailyCheckInDb object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyCheckInDbGetLinks(DailyCheckInDb object) {
  return [];
}

void _dailyCheckInDbAttach(
  IsarCollection<dynamic> col,
  Id id,
  DailyCheckInDb object,
) {
  object.id = id;
}

extension DailyCheckInDbQueryWhereSort
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QWhere> {
  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhere> anyCheckInDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'checkInDate'),
      );
    });
  }
}

extension DailyCheckInDbQueryWhere
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QWhereClause> {
  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause> idBetween(
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

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause>
  checkInDateEqualTo(DateTime checkInDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'checkInDate',
          value: [checkInDate],
        ),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause>
  checkInDateNotEqualTo(DateTime checkInDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkInDate',
                lower: [],
                upper: [checkInDate],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkInDate',
                lower: [checkInDate],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkInDate',
                lower: [checkInDate],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checkInDate',
                lower: [],
                upper: [checkInDate],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause>
  checkInDateGreaterThan(DateTime checkInDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checkInDate',
          lower: [checkInDate],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause>
  checkInDateLessThan(DateTime checkInDate, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checkInDate',
          lower: [],
          upper: [checkInDate],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterWhereClause>
  checkInDateBetween(
    DateTime lowerCheckInDate,
    DateTime upperCheckInDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checkInDate',
          lower: [lowerCheckInDate],
          includeLower: includeLower,
          upper: [upperCheckInDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension DailyCheckInDbQueryFilter
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QFilterCondition> {
  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
  checkInDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'checkInDate', value: value),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
  checkInDateGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'checkInDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
  checkInDateLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'checkInDate',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
  checkInDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'checkInDate',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
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

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
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

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
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

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
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

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition>
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

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterFilterCondition> idBetween(
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

extension DailyCheckInDbQueryObject
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QFilterCondition> {}

extension DailyCheckInDbQueryLinks
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QFilterCondition> {}

extension DailyCheckInDbQuerySortBy
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QSortBy> {
  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy>
  sortByCheckInDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkInDate', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy>
  sortByCheckInDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkInDate', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }
}

extension DailyCheckInDbQuerySortThenBy
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QSortThenBy> {
  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy>
  thenByCheckInDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkInDate', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy>
  thenByCheckInDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checkInDate', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DailyCheckInDbQueryWhereDistinct
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QDistinct> {
  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QDistinct>
  distinctByCheckInDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checkInDate');
    });
  }

  QueryBuilder<DailyCheckInDb, DailyCheckInDb, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }
}

extension DailyCheckInDbQueryProperty
    on QueryBuilder<DailyCheckInDb, DailyCheckInDb, QQueryProperty> {
  QueryBuilder<DailyCheckInDb, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyCheckInDb, DateTime, QQueryOperations>
  checkInDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checkInDate');
    });
  }

  QueryBuilder<DailyCheckInDb, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }
}
