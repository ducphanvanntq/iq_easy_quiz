import 'package:dio/dio.dart';
import '../models/question_model.dart';

class QuizService {
  static final Dio _dio = Dio();

  /// Load questions from Open Trivia Database API
  /// 
  /// Parameters:
  /// - [categoryId]: Category ID (or 'any' for all categories)
  /// - [difficulty]: Difficulty level (easy/medium/hard)
  /// - [amount]: Number of questions (default: 10)
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

  /// Shuffle answers for a question
  static List<String> shuffleAnswers(Question question) {
    return question.getAllAnswers();
  }

  /// Calculate score
  static int calculateScore({
    required List<Question> questions,
    required Map<int, String> userAnswers,
  }) {
    int score = 0;
    
    for (var i = 0; i < questions.length; i++) {
      final userAnswer = userAnswers[i];
      if (userAnswer != null) {
        final correctAnswer = questions[i].correctAnswer;
        // Normalize strings for comparison
        final normalizedUser = userAnswer.trim().toLowerCase();
        final normalizedCorrect = correctAnswer.trim().toLowerCase();
        
        if (normalizedUser == normalizedCorrect) {
          score++;
        }
      }
    }
    
    return score;
  }

  /// Check if user has answered all questions
  static bool hasAnsweredAll({
    required int totalQuestions,
    required Map<int, String> userAnswers,
  }) {
    return userAnswers.length == totalQuestions;
  }

  /// Get unanswered questions indices
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
}

