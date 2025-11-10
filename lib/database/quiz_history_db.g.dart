// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizHistoryDbCollection on Isar {
  IsarCollection<QuizHistoryDb> get quizHistoryDbs => this.collection();
}

const QuizHistoryDbSchema = CollectionSchema(
  name: r'QuizHistoryDb',
  id: 8620587970054604281,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.string,
    ),
    r'categoryTitle': PropertySchema(
      id: 1,
      name: r'categoryTitle',
      type: IsarType.string,
    ),
    r'completedAt': PropertySchema(
      id: 2,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'correctAnswers': PropertySchema(
      id: 3,
      name: r'correctAnswers',
      type: IsarType.long,
    ),
    r'difficulty': PropertySchema(
      id: 4,
      name: r'difficulty',
      type: IsarType.string,
    ),
    r'score': PropertySchema(id: 5, name: r'score', type: IsarType.long),
    r'totalQuestions': PropertySchema(
      id: 6,
      name: r'totalQuestions',
      type: IsarType.long,
    ),
  },

  estimateSize: _quizHistoryDbEstimateSize,
  serialize: _quizHistoryDbSerialize,
  deserialize: _quizHistoryDbDeserialize,
  deserializeProp: _quizHistoryDbDeserializeProp,
  idName: r'id',
  indexes: {
    r'categoryId': IndexSchema(
      id: -8798048739239305339,
      name: r'categoryId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'categoryId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'difficulty': IndexSchema(
      id: 3042583923453520767,
      name: r'difficulty',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'difficulty',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'completedAt': IndexSchema(
      id: -3156591011457686752,
      name: r'completedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'completedAt',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _quizHistoryDbGetId,
  getLinks: _quizHistoryDbGetLinks,
  attach: _quizHistoryDbAttach,
  version: '3.3.0-dev.3',
);

int _quizHistoryDbEstimateSize(
  QuizHistoryDb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.categoryId.length * 3;
  bytesCount += 3 + object.categoryTitle.length * 3;
  bytesCount += 3 + object.difficulty.length * 3;
  return bytesCount;
}

void _quizHistoryDbSerialize(
  QuizHistoryDb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoryId);
  writer.writeString(offsets[1], object.categoryTitle);
  writer.writeDateTime(offsets[2], object.completedAt);
  writer.writeLong(offsets[3], object.correctAnswers);
  writer.writeString(offsets[4], object.difficulty);
  writer.writeLong(offsets[5], object.score);
  writer.writeLong(offsets[6], object.totalQuestions);
}

QuizHistoryDb _quizHistoryDbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizHistoryDb();
  object.categoryId = reader.readString(offsets[0]);
  object.categoryTitle = reader.readString(offsets[1]);
  object.completedAt = reader.readDateTime(offsets[2]);
  object.correctAnswers = reader.readLong(offsets[3]);
  object.difficulty = reader.readString(offsets[4]);
  object.id = id;
  object.score = reader.readLong(offsets[5]);
  object.totalQuestions = reader.readLong(offsets[6]);
  return object;
}

P _quizHistoryDbDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizHistoryDbGetId(QuizHistoryDb object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizHistoryDbGetLinks(QuizHistoryDb object) {
  return [];
}

void _quizHistoryDbAttach(
  IsarCollection<dynamic> col,
  Id id,
  QuizHistoryDb object,
) {
  object.id = id;
}

extension QuizHistoryDbQueryWhereSort
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QWhere> {
  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhere> anyCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'completedAt'),
      );
    });
  }
}

extension QuizHistoryDbQueryWhere
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QWhereClause> {
  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause> idBetween(
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

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  categoryIdEqualTo(String categoryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'categoryId', value: [categoryId]),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  categoryIdNotEqualTo(String categoryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'categoryId',
                lower: [],
                upper: [categoryId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'categoryId',
                lower: [categoryId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'categoryId',
                lower: [categoryId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'categoryId',
                lower: [],
                upper: [categoryId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  difficultyEqualTo(String difficulty) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'difficulty', value: [difficulty]),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  difficultyNotEqualTo(String difficulty) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'difficulty',
                lower: [],
                upper: [difficulty],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'difficulty',
                lower: [difficulty],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'difficulty',
                lower: [difficulty],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'difficulty',
                lower: [],
                upper: [difficulty],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  completedAtEqualTo(DateTime completedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'completedAt',
          value: [completedAt],
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  completedAtNotEqualTo(DateTime completedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'completedAt',
                lower: [],
                upper: [completedAt],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'completedAt',
                lower: [completedAt],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'completedAt',
                lower: [completedAt],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'completedAt',
                lower: [],
                upper: [completedAt],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  completedAtGreaterThan(DateTime completedAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'completedAt',
          lower: [completedAt],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  completedAtLessThan(DateTime completedAt, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'completedAt',
          lower: [],
          upper: [completedAt],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterWhereClause>
  completedAtBetween(
    DateTime lowerCompletedAt,
    DateTime upperCompletedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'completedAt',
          lower: [lowerCompletedAt],
          includeLower: includeLower,
          upper: [upperCompletedAt],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QuizHistoryDbQueryFilter
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QFilterCondition> {
  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'categoryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'categoryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'categoryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'categoryId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'categoryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'categoryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'categoryId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'categoryId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'categoryId', value: ''),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'categoryId', value: ''),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'categoryTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'categoryTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'categoryTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'categoryTitle',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'categoryTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'categoryTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'categoryTitle',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'categoryTitle',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'categoryTitle', value: ''),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  categoryTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'categoryTitle', value: ''),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  completedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'completedAt', value: value),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  completedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'completedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  completedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'completedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  completedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'completedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  correctAnswersEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'correctAnswers', value: value),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  correctAnswersGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'correctAnswers',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  correctAnswersLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'correctAnswers',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  correctAnswersBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'correctAnswers',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'difficulty',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'difficulty',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'difficulty',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'difficulty', value: ''),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'difficulty', value: ''),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
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

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition> idBetween(
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

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  scoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'score', value: value),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  scoreGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'score',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  scoreLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'score',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'score',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  totalQuestionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'totalQuestions', value: value),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  totalQuestionsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'totalQuestions',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  totalQuestionsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'totalQuestions',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterFilterCondition>
  totalQuestionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'totalQuestions',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension QuizHistoryDbQueryObject
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QFilterCondition> {}

extension QuizHistoryDbQueryLinks
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QFilterCondition> {}

extension QuizHistoryDbQuerySortBy
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QSortBy> {
  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByCategoryTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryTitle', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByCategoryTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryTitle', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> sortByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  sortByTotalQuestionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.desc);
    });
  }
}

extension QuizHistoryDbQuerySortThenBy
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QSortThenBy> {
  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByCategoryTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryTitle', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByCategoryTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryTitle', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByCorrectAnswersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswers', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> thenByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy> thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.asc);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QAfterSortBy>
  thenByTotalQuestionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.desc);
    });
  }
}

extension QuizHistoryDbQueryWhereDistinct
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct> {
  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct> distinctByCategoryId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct>
  distinctByCategoryTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'categoryTitle',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct>
  distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct>
  distinctByCorrectAnswers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctAnswers');
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct> distinctByDifficulty({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'difficulty', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }

  QueryBuilder<QuizHistoryDb, QuizHistoryDb, QDistinct>
  distinctByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalQuestions');
    });
  }
}

extension QuizHistoryDbQueryProperty
    on QueryBuilder<QuizHistoryDb, QuizHistoryDb, QQueryProperty> {
  QueryBuilder<QuizHistoryDb, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizHistoryDb, String, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<QuizHistoryDb, String, QQueryOperations>
  categoryTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryTitle');
    });
  }

  QueryBuilder<QuizHistoryDb, DateTime, QQueryOperations>
  completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<QuizHistoryDb, int, QQueryOperations> correctAnswersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctAnswers');
    });
  }

  QueryBuilder<QuizHistoryDb, String, QQueryOperations> difficultyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'difficulty');
    });
  }

  QueryBuilder<QuizHistoryDb, int, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }

  QueryBuilder<QuizHistoryDb, int, QQueryOperations> totalQuestionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalQuestions');
    });
  }
}
