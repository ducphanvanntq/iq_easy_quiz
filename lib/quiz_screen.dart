import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'models/question_model.dart';
import 'models/quiz_history.dart';
import 'services/quiz_history_service.dart';

class QuizScreen extends StatefulWidget {
  final String categoryId;
  final String categoryTitle;
  final String difficulty;
  final Color categoryColor;

  const QuizScreen({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
    required this.difficulty,
    required this.categoryColor,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);

  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  Timer? _timer;
  int timeLeft = 30;
  
  List<Question> questions = [];
  List<List<String>> allShuffledAnswers = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    try {
      final dio = Dio();
      final category = widget.categoryId == 'any' ? '' : '&category=${widget.categoryId}';
      final url = 'https://opentdb.com/api.php?amount=10$category&difficulty=${widget.difficulty}';
      
      final response = await dio.get(url);
      
      if (response.statusCode == 200) {
        final quizResponse = QuizResponse.fromJson(response.data);
        
        if (quizResponse.responseCode == 0 && quizResponse.results.isNotEmpty) {
          setState(() {
            questions = quizResponse.results;
            // Shuffle answers for each question
            for (var question in questions) {
              allShuffledAnswers.add(question.getAllAnswers());
            }
            isLoading = false;
          });
          _startTimer();
        } else {
          setState(() {
            errorMessage = 'No questions available for this category';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load questions: $e';
        isLoading = false;
      });
    }
  }

  void _startTimer() {
    timeLeft = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _selectAnswer(int index) {
    if (isAnswered) return;

    final shuffledAnswers = allShuffledAnswers[currentQuestionIndex];
    final selectedAnswer = shuffledAnswers[index];
    final correctAnswer = questions[currentQuestionIndex].correctAnswer;

    setState(() {
      selectedAnswerIndex = index;
      isAnswered = true;
      if (selectedAnswer == correctAnswer) {
        score++;
      }
    });

    _timer?.cancel();

    Future.delayed(const Duration(seconds: 2), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        isAnswered = false;
      });
      _startTimer();
    } else {
      _saveHistory();
      _showResultDialog();
    }
  }

  Future<void> _saveHistory() async {
    final history = QuizHistory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      categoryId: widget.categoryId,
      categoryTitle: widget.categoryTitle,
      difficulty: widget.difficulty,
      totalQuestions: questions.length,
      correctAnswers: score,
      score: ((score / questions.length) * 100).toInt(),
      completedAt: DateTime.now(),
    );
    
    await QuizHistoryService.saveHistory(history);
  }

  void _showResultDialog() {
    _timer?.cancel();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(32),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                score >= questions.length * 0.7
                    ? PhosphorIcons.trophy(PhosphorIconsStyle.fill)
                    : PhosphorIcons.smiley(PhosphorIconsStyle.fill),
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Quiz Completed!',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your Score',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$score / ${questions.length}',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Back to Home',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: widget.categoryColor,
          title: Text(
            widget.categoryTitle,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                'Loading questions...',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: widget.categoryColor,
          title: Text(
            widget.categoryTitle,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.warning(PhosphorIconsStyle.fill),
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 24),
                Text(
                  'Error',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Go Back',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final question = questions[currentQuestionIndex];
    final shuffledAnswers = allShuffledAnswers[currentQuestionIndex];
    final correctAnswerIndex = shuffledAnswers.indexOf(question.correctAnswer);
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: widget.categoryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryTitle,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.categoryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.listNumbers(PhosphorIconsStyle.bold),
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${currentQuestionIndex + 1}/${questions.length}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: timeLeft <= 10
                            ? Colors.red.withOpacity(0.3)
                            : Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Ionicons.timer,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${timeLeft}s',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.trophy(PhosphorIconsStyle.fill),
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Score: $score',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      question.question,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(
                    shuffledAnswers.length,
                    (index) => _buildAnswerOption(
                      shuffledAnswers[index],
                      index,
                      correctAnswerIndex,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(String answer, int index, int correctIndex) {
    bool isSelected = selectedAnswerIndex == index;
    bool isCorrect = index == correctIndex;
    
    Color getColor() {
      if (!isAnswered) {
        return isSelected ? primaryColor.withOpacity(0.1) : Colors.white;
      }
      if (isCorrect) {
        return Colors.green.withOpacity(0.2);
      }
      if (isSelected && !isCorrect) {
        return Colors.red.withOpacity(0.2);
      }
      return Colors.white;
    }

    Color getBorderColor() {
      if (!isAnswered) {
        return isSelected ? primaryColor : Colors.grey.shade300;
      }
      if (isCorrect) {
        return Colors.green;
      }
      if (isSelected && !isCorrect) {
        return Colors.red;
      }
      return Colors.grey.shade300;
    }

    IconData? getIcon() {
      if (!isAnswered) return null;
      if (isCorrect) {
        return PhosphorIcons.checkCircle(PhosphorIconsStyle.fill);
      }
      if (isSelected && !isCorrect) {
        return PhosphorIcons.xCircle(PhosphorIconsStyle.fill);
      }
      return null;
    }

    Color? getIconColor() {
      if (!isAnswered) return null;
      if (isCorrect) return Colors.green;
      if (isSelected && !isCorrect) return Colors.red;
      return null;
    }

    return GestureDetector(
      onTap: () => _selectAnswer(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: getBorderColor(),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: getBorderColor().withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: getBorderColor(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                answer,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            if (getIcon() != null)
              Icon(
                getIcon(),
                color: getIconColor(),
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
