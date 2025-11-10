import 'package:isar_community/isar.dart';

part 'quiz_history_db.g.dart';

@collection
class QuizHistoryDb {
  Id id = Isar.autoIncrement;

  @Index()
  late String categoryId;

  late String categoryTitle;

  @Index()
  late String difficulty;

  late int totalQuestions;

  late int correctAnswers;

  late int score;

  @Index()
  late DateTime completedAt;

  // Computed property (không lưu vào DB)
  @ignore
  double get percentage => totalQuestions > 0
      ? (correctAnswers / totalQuestions) * 100
      : 0.0;
}
