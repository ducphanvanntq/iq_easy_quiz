import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'models/question_model.dart';
import 'models/quiz_history.dart';
import 'services/quiz_service.dart';
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

  List<Question> questions = [];
  List<List<String>> allShuffledAnswers = [];
  Map<int, String> userAnswers = {}; // questionIndex -> selectedAnswer
  bool isLoading = true;
  String? errorMessage;

  int currentQuestionIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestions() async {
    try {
      final loadedQuestions = await QuizService.loadQuestions(
        categoryId: widget.categoryId,
        difficulty: widget.difficulty,
        amount: 10,
      );

      setState(() {
        questions = loadedQuestions;
        // Shuffle answers for each question
        for (var question in questions) {
          allShuffledAnswers.add(QuizService.shuffleAnswers(question));
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _selectAnswer(int questionIndex, String answer) {
    setState(() {
      userAnswers[questionIndex] = answer;
    });
  }

  void _goToQuestion(int index) {
    setState(() {
      currentQuestionIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      _goToQuestion(currentQuestionIndex - 1);
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      _goToQuestion(currentQuestionIndex + 1);
    }
  }

  void _submitQuiz() {
    // Check if user has answered all questions
    if (!QuizService.hasAnsweredAll(
      totalQuestions: questions.length,
      userAnswers: userAnswers,
    )) {
      _showIncompleteWarning();
      return;
    }

    // Calculate score
    final score = QuizService.calculateScore(
      questions: questions,
      userAnswers: userAnswers,
    );

    // Save history
    _saveHistory(score).then((_) {
      if (mounted) {
        _showResultDialog(score);
      }
    });
  }

  void _showIncompleteWarning() {
    final unansweredQuestions = QuizService.getUnansweredQuestions(
      totalQuestions: questions.length,
      userAnswers: userAnswers,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Icon(
              PhosphorIcons.warning(PhosphorIconsStyle.fill),
              color: Colors.orange,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Incomplete Quiz',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You haven\'t answered all questions yet!',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Unanswered questions: ${unansweredQuestions.map((i) => i + 1).join(", ")}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Do you want to submit anyway?',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Go Back',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              final score = QuizService.calculateScore(
                questions: questions,
                userAnswers: userAnswers,
              );
              _saveHistory(score).then((_) {
                if (mounted) {
                  _showResultDialog(score);
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Submit Anyway',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveHistory(int score) async {
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

  void _showResultDialog(int score) {
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
            const SizedBox(height: 8),
            Text(
              '${((score / questions.length) * 100).toInt()}%',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
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

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: widget.categoryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            // Show confirmation dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Exit Quiz?',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'Your progress will be lost.',
                  style: GoogleFonts.poppins(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel', style: GoogleFonts.poppins()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Exit', style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        ),
        title: Text(
          widget.categoryTitle,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header with progress
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
                // Question progress
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${userAnswers.length}/${questions.length}',
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
                // Question number grid
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final isAnswered = userAnswers.containsKey(index);
                      final isCurrent = index == currentQuestionIndex;

                      return GestureDetector(
                        onTap: () => _goToQuestion(index),
                        child: Container(
                          width: 45,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? Colors.white
                                : isAnswered
                                    ? Colors.green.withOpacity(0.3)
                                    : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isCurrent
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: GoogleFonts.poppins(
                                color: isCurrent
                                    ? widget.categoryColor
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Question content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: questions.length,
              onPageChanged: (index) {
                setState(() {
                  currentQuestionIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final question = questions[index];
                final shuffledAnswers = allShuffledAnswers[index];
                final selectedAnswer = userAnswers[index];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question
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

                      // Answers
                      ...List.generate(
                        shuffledAnswers.length,
                        (answerIndex) => _buildAnswerOption(
                          shuffledAnswers[answerIndex],
                          answerIndex,
                          index,
                          selectedAnswer,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _previousQuestion,
                      icon: Icon(
                        Ionicons.chevron_back,
                        color: primaryColor,
                      ),
                      label: Text(
                        'Previous',
                        style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                if (currentQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  flex: currentQuestionIndex == 0 ? 1 : 1,
                  child: currentQuestionIndex < questions.length - 1
                      ? ElevatedButton.icon(
                          onPressed: _nextQuestion,
                          icon: const Icon(Ionicons.chevron_forward,
                              color: Colors.white),
                          label: Text(
                            'Next',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: _submitQuiz,
                          icon: const Icon(
                            Ionicons.checkmark_circle,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Submit Quiz',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(
    String answer,
    int answerIndex,
    int questionIndex,
    String? selectedAnswer,
  ) {
    final isSelected = selectedAnswer == answer;

    return GestureDetector(
      onTap: () => _selectAnswer(questionIndex, answer),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor
                    : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + answerIndex),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
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
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                color: primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
