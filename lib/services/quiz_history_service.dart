import '../models/quiz_history.dart';
import '../database/database.dart';
import '../database/quiz_history_db.dart';
import 'package:isar_community/isar.dart';

class QuizHistoryService {
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

  static Future<void> saveHistory(QuizHistory history) async {
    final isar = await IsarDatabase.instance;
    final dbHistory = _toDb(history);

    await isar.writeTxn(() async {
      await isar.quizHistoryDbs.put(dbHistory);
    });

    await _keepOnlyRecentRecords(100);
  }

  static Future<List<QuizHistory>> getAllHistory() async {
    final isar = await IsarDatabase.instance;
    
    final allIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final dbHistories = await isar.quizHistoryDbs.getAll(allIds);
    
    final validHistories = dbHistories.where((h) => h != null).cast<QuizHistoryDb>().toList();
    validHistories.sort((a, b) => b.completedAt.compareTo(a.completedAt));

    return validHistories.map(_fromDb).toList();
  }

  static Future<List<QuizHistory>> getHistoryByCategory(String categoryId) async {
    final allHistories = await getAllHistory();
    return allHistories.where((h) => h.categoryId == categoryId).toList();
  }

  static Future<List<QuizHistory>> getHistoryByDifficulty(String difficulty) async {
    final allHistories = await getAllHistory();
    return allHistories.where((h) => h.difficulty == difficulty).toList();
  }

  static Future<List<QuizHistory>> getRecentHistory([int limit = 10]) async {
    final allHistories = await getAllHistory();
    return allHistories.take(limit).toList();
  }

  static Future<void> clearHistory() async {
    final isar = await IsarDatabase.instance;
    await isar.writeTxn(() async {
      await isar.quizHistoryDbs.clear();
    });
  }

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

  static Future<int> getQuizCount() async {
    final isar = await IsarDatabase.instance;
    return await isar.quizHistoryDbs.count();
  }

  static Future<int> getQuizCountByCategory(String categoryId) async {
    final histories = await getHistoryByCategory(categoryId);
    return histories.length;
  }

  static Future<List<QuizHistory>> getHistoryByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final allHistories = await getAllHistory();
    
    return allHistories.where((h) =>
      h.completedAt.isAfter(startDate) && h.completedAt.isBefore(endDate)
    ).toList();
  }

  static Future<List<QuizHistory>> getBestScores([int limit = 10]) async {
    final allHistory = await getAllHistory();
    allHistory.sort((a, b) => b.percentage.compareTo(a.percentage));
    return allHistory.take(limit).toList();
  }

  static Future<int> getTotalQuestionsAnswered() async {
    final stats = await getStatistics();
    return stats['totalQuestions'] as int;
  }

  static Future<int> getTotalCorrectAnswers() async {
    final stats = await getStatistics();
    return stats['correctAnswers'] as int;
  }

  static Future<double> getAverageScore() async {
    final stats = await getStatistics();
    return stats['averageScore'] as double;
  }

  static Future<double> getBestScore() async {
    final stats = await getStatistics();
    return stats['bestScore'] as double? ?? 0.0;
  }

  static Future<bool> hasCompletedAnyQuiz() async {
    final count = await getQuizCount();
    return count > 0;
  }

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
