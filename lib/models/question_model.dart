class QuizResponse {
  final int responseCode;
  final List<Question> results;

  QuizResponse({
    required this.responseCode,
    required this.results,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      responseCode: json['response_code'] as int,
      results: (json['results'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final String type;
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Question({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'] as String,
      difficulty: json['difficulty'] as String,
      category: json['category'] as String,
      question: _decodeHtml(json['question'] as String),
      correctAnswer: _decodeHtml(json['correct_answer'] as String),
      incorrectAnswers: (json['incorrect_answers'] as List)
          .map((answer) => _decodeHtml(answer as String))
          .toList(),
    );
  }

  static String _decodeHtml(String text) {
    return text
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&rsquo;', "'")
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rdquo;', '"')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&eacute;', 'é')
        .replaceAll('&uuml;', 'ü');
  }

  List<String> getAllAnswers() {
    final allAnswers = [...incorrectAnswers, correctAnswer];
    allAnswers.shuffle();
    return allAnswers;
  }

  int getCorrectAnswerIndex(List<String> shuffledAnswers) {
    return shuffledAnswers.indexOf(correctAnswer);
  }
}

