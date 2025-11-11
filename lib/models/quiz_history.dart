import 'dart:convert';

class QuizHistory {
  final String id;
  final String categoryId;
  final String categoryTitle;
  final String difficulty;
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final DateTime completedAt;

  QuizHistory({
    required this.id,
    required this.categoryId,
    required this.categoryTitle,
    required this.difficulty,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryTitle': categoryTitle,
      'difficulty': difficulty,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'score': score,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  factory QuizHistory.fromJson(Map<String, dynamic> json) {
    return QuizHistory(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      categoryTitle: json['categoryTitle'] as String,
      difficulty: json['difficulty'] as String,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      score: json['score'] as int,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );
  }

  double get percentage => (correctAnswers / totalQuestions) * 100;

  String toJsonString() => jsonEncode(toJson());

  static QuizHistory fromJsonString(String jsonString) {
    return QuizHistory.fromJson(jsonDecode(jsonString));
  }
}

