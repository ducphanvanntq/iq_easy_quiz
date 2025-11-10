import '../models/quiz_history.dart';
import '../database/database.dart';
import '../database/quiz_history_db.dart';
import 'package:isar_community/isar.dart';

class QuizHistoryService {
  // Convert QuizHistory model to QuizHistoryDb (Isar model)
  static QuizHistoryDb _toDb(QuizHistory history) {
    return QuizHistoryDb()
      ..categoryId = history.categoryId
      ..categoryTitle = history.categoryTitle
      ..difficulty = history.difficulty
      ..totalQuestions = history.totalQuestions
      ..correctAnswers = history.correctAnswers
      ..score = history.score
      ..completedAt = history.completedAt;
  }

  // Convert QuizHistoryDb (Isar model) to QuizHistory model
  static QuizHistory _fromDb(QuizHistoryDb db) {
    return QuizHistory(
      id: db.id.toString(),
      categoryId: db.categoryId,
      categoryTitle: db.categoryTitle,
      difficulty: db.difficulty,
      totalQuestions: db.totalQuestions,
      correctAnswers: db.correctAnswers,
      score: db.score,
      completedAt: db.completedAt,
    );
  }

  // Save quiz history
  static Future<void> saveHistory(QuizHistory history) async {
    final isar = await IsarDatabase.instance;
    final dbHistory = _toDb(history);

    await isar.writeTxn(() async {
      await isar.quizHistoryDbs.put(dbHistory);
    });

    // Keep only last 100 records
    await _keepOnlyRecentRecords(100);
  }

  // Get all history (sorted by date, newest first)
  static Future<List<QuizHistory>> getAllHistory() async {
    final isar = await IsarDatabase.instance;
    
    // Get all records
    final allIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final dbHistories = await isar.quizHistoryDbs.getAll(allIds);
    
    // Filter out nulls and sort
    final validHistories = dbHistories.where((h) => h != null).cast<QuizHistoryDb>().toList();
    validHistories.sort((a, b) => b.completedAt.compareTo(a.completedAt));

    return validHistories.map(_fromDb).toList();
  }

  // Get history by category
  static Future<List<QuizHistory>> getHistoryByCategory(String categoryId) async {
    final allHistories = await getAllHistory();
    return allHistories.where((h) => h.categoryId == categoryId).toList();
  }

  // Get history by difficulty
  static Future<List<QuizHistory>> getHistoryByDifficulty(String difficulty) async {
    final allHistories = await getAllHistory();
    return allHistories.where((h) => h.difficulty == difficulty).toList();
  }

  // Get recent history (last N records)
  static Future<List<QuizHistory>> getRecentHistory([int limit = 10]) async {
    final allHistories = await getAllHistory();
    return allHistories.take(limit).toList();
  }

  // Clear all history
  static Future<void> clearHistory() async {
    final isar = await IsarDatabase.instance;
    await isar.writeTxn(() async {
      await isar.quizHistoryDbs.clear();
    });
  }

  // Delete specific history by id
  static Future<bool> deleteHistory(String id) async {
    final isar = await IsarDatabase.instance;
    final historyId = int.tryParse(id);
    if (historyId == null) return false;

    bool deleted = false;
    await isar.writeTxn(() async {
      deleted = await isar.quizHistoryDbs.delete(historyId);
    });
    return deleted;
  }

  // Get statistics
  static Future<Map<String, dynamic>> getStatistics() async {
    final allHistory = await getAllHistory();

    if (allHistory.isEmpty) {
      return {
        'totalQuizzes': 0,
        'totalQuestions': 0,
        'correctAnswers': 0,
        'averageScore': 0.0,
        'bestScore': 0.0,
        'worstScore': 0.0,
      };
    }

    final totalQuizzes = allHistory.length;
    final totalQuestions = allHistory.fold<int>(
      0,
      (sum, h) => sum + h.totalQuestions,
    );
    final correctAnswers = allHistory.fold<int>(
      0,
      (sum, h) => sum + h.correctAnswers,
    );
    final averageScore = allHistory.fold<double>(
          0,
          (sum, h) => sum + h.percentage,
        ) /
        totalQuizzes;

    final scores = allHistory.map((h) => h.percentage).toList()..sort();
    final bestScore = scores.last;
    final worstScore = scores.first;

    return {
      'totalQuizzes': totalQuizzes,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'averageScore': averageScore,
      'bestScore': bestScore,
      'worstScore': worstScore,
    };
  }

  // Get statistics by category
  static Future<Map<String, dynamic>> getStatisticsByCategory(
    String categoryId,
  ) async {
    final categoryHistory = await getHistoryByCategory(categoryId);

    if (categoryHistory.isEmpty) {
      return {
        'totalQuizzes': 0,
        'totalQuestions': 0,
        'correctAnswers': 0,
        'averageScore': 0.0,
      };
    }

    final totalQuizzes = categoryHistory.length;
    final totalQuestions = categoryHistory.fold<int>(
      0,
      (sum, h) => sum + h.totalQuestions,
    );
    final correctAnswers = categoryHistory.fold<int>(
      0,
      (sum, h) => sum + h.correctAnswers,
    );
    final averageScore = categoryHistory.fold<double>(
          0,
          (sum, h) => sum + h.percentage,
        ) /
        totalQuizzes;

    return {
      'totalQuizzes': totalQuizzes,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'averageScore': averageScore,
    };
  }

  // Get count
  static Future<int> getQuizCount() async {
    final isar = await IsarDatabase.instance;
    return await isar.quizHistoryDbs.count();
  }

  // Get count by category
  static Future<int> getQuizCountByCategory(String categoryId) async {
    final histories = await getHistoryByCategory(categoryId);
    return histories.length;
  }

  // Get history by date range
  static Future<List<QuizHistory>> getHistoryByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final allHistories = await getAllHistory();
    
    return allHistories.where((h) =>
      h.completedAt.isAfter(startDate) && h.completedAt.isBefore(endDate)
    ).toList();
  }

  // Get best scores (top N)
  static Future<List<QuizHistory>> getBestScores([int limit = 10]) async {
    final allHistory = await getAllHistory();
    allHistory.sort((a, b) => b.percentage.compareTo(a.percentage));
    return allHistory.take(limit).toList();
  }

  // Get total questions answered
  static Future<int> getTotalQuestionsAnswered() async {
    final stats = await getStatistics();
    return stats['totalQuestions'] as int;
  }

  // Get total correct answers
  static Future<int> getTotalCorrectAnswers() async {
    final stats = await getStatistics();
    return stats['correctAnswers'] as int;
  }

  // Get average score
  static Future<double> getAverageScore() async {
    final stats = await getStatistics();
    return stats['averageScore'] as double;
  }

  // Get best score
  static Future<double> getBestScore() async {
    final stats = await getStatistics();
    return stats['bestScore'] as double? ?? 0.0;
  }

  // Check if user has completed any quiz
  static Future<bool> hasCompletedAnyQuiz() async {
    final count = await getQuizCount();
    return count > 0;
  }

  // Private: Keep only recent records
  static Future<void> _keepOnlyRecentRecords(int limit) async {
    final allHistories = await getAllHistory();

    if (allHistories.length > limit) {
      final isar = await IsarDatabase.instance;
      final toDelete = allHistories.skip(limit).toList();
      
      await isar.writeTxn(() async {
        for (var history in toDelete) {
          final historyId = int.tryParse(history.id);
          if (historyId != null) {
            await isar.quizHistoryDbs.delete(historyId);
          }
        }
      });
    }
  }
}
