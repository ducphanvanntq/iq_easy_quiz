import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_history.dart';

class QuizHistoryService {
  static const String _historyKey = 'quiz_history';

  // Save quiz history
  static Future<void> saveHistory(QuizHistory history) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> historyList = prefs.getStringList(_historyKey) ?? [];
    
    historyList.insert(0, history.toJsonString());
    
    // Keep only last 50 records
    if (historyList.length > 50) {
      historyList.removeRange(50, historyList.length);
    }
    
    await prefs.setStringList(_historyKey, historyList);
  }

  // Get all history
  static Future<List<QuizHistory>> getAllHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> historyList = prefs.getStringList(_historyKey) ?? [];
    
    return historyList
        .map((jsonString) => QuizHistory.fromJsonString(jsonString))
        .toList();
  }

  // Get history by category
  static Future<List<QuizHistory>> getHistoryByCategory(String categoryId) async {
    final allHistory = await getAllHistory();
    return allHistory.where((h) => h.categoryId == categoryId).toList();
  }

  // Clear all history
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
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
      };
    }
    
    final totalQuizzes = allHistory.length;
    final totalQuestions = allHistory.fold<int>(0, (sum, h) => sum + h.totalQuestions);
    final correctAnswers = allHistory.fold<int>(0, (sum, h) => sum + h.correctAnswers);
    final averageScore = allHistory.fold<double>(0, (sum, h) => sum + h.percentage) / totalQuizzes;
    
    return {
      'totalQuizzes': totalQuizzes,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'averageScore': averageScore,
    };
  }
}

