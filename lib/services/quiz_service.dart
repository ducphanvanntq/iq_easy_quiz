import 'package:dio/dio.dart';
import 'package:isar_community/isar.dart';
import '../models/question_model.dart';
import '../database/database.dart';
import '../database/quiz_db.dart';

class QuizService {
  static final Dio _dio = Dio();

  static Future<List<Question>> loadQuestions({
    required String categoryId,
    required String difficulty,
    int amount = 10,
  }) async {
    try {
      final category = categoryId == 'any' ? '' : '&category=$categoryId';
      final url = 'https://opentdb.com/api.php?amount=$amount$category&difficulty=$difficulty';
      
      final response = await _dio.get(url);
      
      if (response.statusCode == 200) {
        final quizResponse = QuizResponse.fromJson(response.data);
        
        if (quizResponse.responseCode == 0 && quizResponse.results.isNotEmpty) {
          return quizResponse.results;
        } else {
          throw Exception('No questions available for this category');
        }
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading questions: $e');
    }
  }

  static List<String> shuffleAnswers(Question question) {
    return question.getAllAnswers();
  }

  static int calculateScore({
    required List<Question> questions,
    required Map<int, String> userAnswers,
  }) {
    int score = 0;
    
    for (var i = 0; i < questions.length; i++) {
      final userAnswer = userAnswers[i];
      if (userAnswer != null) {
        final correctAnswer = questions[i].correctAnswer;
        final normalizedUser = userAnswer.trim().toLowerCase();
        final normalizedCorrect = correctAnswer.trim().toLowerCase();
        
        if (normalizedUser == normalizedCorrect) {
          score++;
        }
      }
    }
    
    return score;
  }

  static bool hasAnsweredAll({
    required int totalQuestions,
    required Map<int, String> userAnswers,
  }) {
    return userAnswers.length == totalQuestions;
  }

  static List<int> getUnansweredQuestions({
    required int totalQuestions,
    required Map<int, String> userAnswers,
  }) {
    final unanswered = <int>[];
    for (var i = 0; i < totalQuestions; i++) {
      if (!userAnswers.containsKey(i)) {
        unanswered.add(i);
      }
    }
    return unanswered;
  }

  static Future<void> saveCustomQuestion({
    required String categoryId,
    required String categoryTitle,
    required String difficulty,
    required String type,
    required String question,
    required String correctAnswer,
    required List<String> incorrectAnswers,
    required String createdBy,
    String status = 'pending',
  }) async {
    final isar = await IsarDatabase.instance;
    
    final quizDb = QuizDb()
      ..categoryId = categoryId
      ..categoryTitle = categoryTitle
      ..difficulty = difficulty
      ..type = type
      ..question = question
      ..correctAnswer = correctAnswer
      ..incorrectAnswers = incorrectAnswers
      ..status = status
      ..createdAt = DateTime.now()
      ..createdBy = createdBy;

    await isar.writeTxn(() async {
      await isar.quizDbs.put(quizDb);
    });
  }

  static Future<List<QuizDb>> getAllCustomQuestions() async {
    final isar = await IsarDatabase.instance;
    return await isar.quizDbs
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }

  static Future<List<QuizDb>> getCustomQuestionsByCategory(String categoryId) async {
    final isar = await IsarDatabase.instance;
    return await isar.quizDbs
        .filter()
        .categoryIdEqualTo(categoryId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  static Future<List<QuizDb>> getCustomQuestionsByStatus(String status) async {
    final isar = await IsarDatabase.instance;
    return await isar.quizDbs
        .filter()
        .statusEqualTo(status)
        .sortByCreatedAtDesc()
        .findAll();
  }

  static Future<List<QuizDb>> getPendingQuestions() async {
    return await getCustomQuestionsByStatus('pending');
  }

  static Future<List<QuizDb>> getApprovedQuestions() async {
    return await getCustomQuestionsByStatus('approved');
  }

  static Future<void> approveQuestion(Id questionId) async {
    final isar = await IsarDatabase.instance;
    await isar.writeTxn(() async {
      final question = await isar.quizDbs.get(questionId);
      if (question != null) {
        question.status = 'approved';
        await isar.quizDbs.put(question);
      }
    });
  }

  static Future<void> deleteCustomQuestion(Id questionId) async {
    final isar = await IsarDatabase.instance;
    await isar.writeTxn(() async {
      await isar.quizDbs.delete(questionId);
    });
  }

  static Future<int> getCustomQuestionsCountByStatus(String status) async {
    final isar = await IsarDatabase.instance;
    return await isar.quizDbs
        .filter()
        .statusEqualTo(status)
        .count();
  }

  static Future<int> getTotalCustomQuestionsCount() async {
    final isar = await IsarDatabase.instance;
    return await isar.quizDbs.count();
  }
}

