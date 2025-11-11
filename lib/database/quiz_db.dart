import 'package:isar_community/isar.dart';

part 'quiz_db.g.dart';

@collection
class QuizDb {
  Id id = Isar.autoIncrement;

  @Index()
  late String categoryId;

  late String categoryTitle;

  @Index()
  late String difficulty;

  late String type;

  late String question;

  late String correctAnswer;

  late List<String> incorrectAnswers;

  @Index()
  late String status;

  late DateTime createdAt;

  late String createdBy;

  @ignore
  List<String> get allAnswers {
    final answers = [...incorrectAnswers, correctAnswer];
    return answers..shuffle();
  }

  @ignore
  int get totalAnswers => incorrectAnswers.length + 1;
}

