import 'package:isar_community/isar.dart';
import '../database/database.dart';
import '../database/quiz_history_db.dart';
import '../database/daily_mission_db.dart';

class StatisticsService {
  static Future<Map<String, dynamic>> getOverallStats() async {
    final isar = await IsarDatabase.instance;

    final allQuizIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final allQuizzes = await isar.quizHistoryDbs.getAll(allQuizIds);
    final validQuizzes = allQuizzes.where((q) => q != null).cast<QuizHistoryDb>().toList();

    final allMissionIds = await isar.dailyMissionDbs.where().idProperty().findAll();
    final allMissions = await isar.dailyMissionDbs.getAll(allMissionIds);
    final validMissions = allMissions.where((m) => m != null).cast<DailyMissionDb>().toList();

    final totalQuizzes = validQuizzes.length;
    final totalCorrectAnswers = validQuizzes.fold<int>(0, (sum, q) => sum + q.correctAnswers);
    final totalQuestions = validQuizzes.fold<int>(0, (sum, q) => sum + q.totalQuestions);
    final averageScore = totalQuestions > 0 
        ? ((totalCorrectAnswers / totalQuestions) * 100).toInt() 
        : 0;

    final totalMissions = validMissions.length;
    final completedMissions = validMissions.where((m) => m.isCompleted).length;
    final missionCompletionRate = totalMissions > 0 
        ? ((completedMissions / totalMissions) * 100).toInt() 
        : 0;

    return {
      'totalQuizzes': totalQuizzes,
      'averageScore': averageScore,
      'totalCorrectAnswers': totalCorrectAnswers,
      'totalQuestions': totalQuestions,
      'totalMissions': totalMissions,
      'completedMissions': completedMissions,
      'missionCompletionRate': missionCompletionRate,
    };
  }

  static Future<Map<String, int>> getQuizzesByDifficulty() async {
    final isar = await IsarDatabase.instance;
    final allIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final allQuizzes = await isar.quizHistoryDbs.getAll(allIds);
    final validQuizzes = allQuizzes.where((q) => q != null).cast<QuizHistoryDb>().toList();

    final easyCount = validQuizzes.where((q) => q.difficulty == 'easy').length;
    final mediumCount = validQuizzes.where((q) => q.difficulty == 'medium').length;
    final hardCount = validQuizzes.where((q) => q.difficulty == 'hard').length;

    return {
      'easy': easyCount,
      'medium': mediumCount,
      'hard': hardCount,
    };
  }

  static Future<Map<String, double>> getAverageScoreByDifficulty() async {
    final isar = await IsarDatabase.instance;
    final allIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final allQuizzes = await isar.quizHistoryDbs.getAll(allIds);
    final validQuizzes = allQuizzes.where((q) => q != null).cast<QuizHistoryDb>().toList();

    final easyQuizzes = validQuizzes.where((q) => q.difficulty == 'easy').toList();
    final mediumQuizzes = validQuizzes.where((q) => q.difficulty == 'medium').toList();
    final hardQuizzes = validQuizzes.where((q) => q.difficulty == 'hard').toList();

    double calculateAverage(List<QuizHistoryDb> quizzes) {
      if (quizzes.isEmpty) return 0.0;
      return quizzes.fold<double>(0.0, (sum, q) => sum + q.score) / quizzes.length;
    }

    return {
      'easy': calculateAverage(easyQuizzes),
      'medium': calculateAverage(mediumQuizzes),
      'hard': calculateAverage(hardQuizzes),
    };
  }

  static Future<Map<String, int>> getTopCategories() async {
    final isar = await IsarDatabase.instance;
    final allIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final allQuizzes = await isar.quizHistoryDbs.getAll(allIds);
    final validQuizzes = allQuizzes.where((q) => q != null).cast<QuizHistoryDb>().toList();

    final categoryCount = <String, int>{};
    for (var quiz in validQuizzes) {
      categoryCount[quiz.categoryTitle] = (categoryCount[quiz.categoryTitle] ?? 0) + 1;
    }

    final sortedCategories = categoryCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedCategories.take(5));
  }

  static Future<List<Map<String, dynamic>>> getLast7DaysActivity() async {
    final isar = await IsarDatabase.instance;
    final now = DateTime.now();
    final last7Days = List.generate(7, (i) {
      final date = now.subtract(Duration(days: 6 - i));
      return DateTime(date.year, date.month, date.day);
    });

    final allQuizIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final allQuizzes = await isar.quizHistoryDbs.getAll(allQuizIds);
    final validQuizzes = allQuizzes.where((q) => q != null).cast<QuizHistoryDb>().toList();

    final allMissionIds = await isar.dailyMissionDbs.where().idProperty().findAll();
    final allMissions = await isar.dailyMissionDbs.getAll(allMissionIds);
    final validMissions = allMissions.where((m) => m != null).cast<DailyMissionDb>().toList();

    return last7Days.map((date) {
      final quizzesOnDate = validQuizzes.where((q) {
        final quizDate = DateTime(
          q.completedAt.year,
          q.completedAt.month,
          q.completedAt.day,
        );
        return quizDate == date;
      }).length;

      final missionsOnDate = validMissions.where((m) {
        final missionDate = DateTime(
          m.missionDate.year,
          m.missionDate.month,
          m.missionDate.day,
        );
        return missionDate == date && m.isCompleted;
      }).length;

      return {
        'date': date,
        'quizzes': quizzesOnDate,
        'missions': missionsOnDate,
      };
    }).toList();
  }

  static Future<List<Map<String, dynamic>>> getRecentQuizzes({int limit = 10}) async {
    final isar = await IsarDatabase.instance;
    final allIds = await isar.quizHistoryDbs.where().idProperty().findAll();
    final allQuizzes = await isar.quizHistoryDbs.getAll(allIds);
    final validQuizzes = allQuizzes.where((q) => q != null).cast<QuizHistoryDb>().toList();

    validQuizzes.sort((a, b) => b.completedAt.compareTo(a.completedAt));

    return validQuizzes.take(limit).map((q) => {
      'categoryTitle': q.categoryTitle,
      'difficulty': q.difficulty,
      'score': q.score,
      'completedAt': q.completedAt,
    }).toList();
  }

  static Future<Map<String, dynamic>> getMissionStats() async {
    final isar = await IsarDatabase.instance;
    final allIds = await isar.dailyMissionDbs.where().idProperty().findAll();
    final allMissions = await isar.dailyMissionDbs.getAll(allIds);
    final validMissions = allMissions.where((m) => m != null).cast<DailyMissionDb>().toList();

    final easyMissions = validMissions.where((m) => m.difficulty == 'easy').toList();
    final mediumMissions = validMissions.where((m) => m.difficulty == 'medium').toList();
    final hardMissions = validMissions.where((m) => m.difficulty == 'hard').toList();

    return {
      'easy': {
        'total': easyMissions.length,
        'completed': easyMissions.where((m) => m.isCompleted).length,
      },
      'medium': {
        'total': mediumMissions.length,
        'completed': mediumMissions.where((m) => m.isCompleted).length,
      },
      'hard': {
        'total': hardMissions.length,
        'completed': hardMissions.where((m) => m.isCompleted).length,
      },
    };
  }
}

