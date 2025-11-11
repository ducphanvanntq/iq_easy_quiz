import 'dart:async';
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
  
  static const int quizDurationInSeconds = 600;
  int remainingSeconds = quizDurationInSeconds;
  bool isTimerRunning = false;
  late final Stream<int> _timerStream;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _initTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    isTimerRunning = false;
    super.dispose();
  }
  
  void _initTimer() {
    _timerStream = Stream.periodic(const Duration(seconds: 1), (count) {
      return quizDurationInSeconds - count - 1;
    }).takeWhile((seconds) => seconds >= 0 && isTimerRunning);
  }
  
  void _startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    
    _timerStream.listen(
      (seconds) {
        if (mounted) {
          setState(() {
            remainingSeconds = seconds;
          });
        }
      },
      onDone: () {
        if (mounted && isTimerRunning) {
          _handleTimeUp();
        }
      },
    );
  }
  
  void _handleTimeUp() {
    setState(() {
      isTimerRunning = false;
    });
    
    final score = QuizService.calculateScore(
      questions: questions,
      userAnswers: userAnswers,
    );
    
    _saveHistory(score).then((_) {
      if (mounted) {
        _showTimeUpDialog(score);
      }
    });
  }
  
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
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
        for (var question in questions) {
          allShuffledAnswers.add(QuizService.shuffleAnswers(question));
        }
        isLoading = false;
      });
      
      _startTimer();
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
    setState(() {
      isTimerRunning = false;
    });
    
    if (!QuizService.hasAnsweredAll(
      totalQuestions: questions.length,
      userAnswers: userAnswers,
    )) {
      _showIncompleteWarning();
      return;
    }

    final score = QuizService.calculateScore(
      questions: questions,
      userAnswers: userAnswers,
    );

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
              setState(() {
                isTimerRunning = false;
              });
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
  
  void _showTimeUpDialog(int score) {
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
                  colors: [Colors.orange.shade400, Colors.red.shade400],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                PhosphorIcons.clock(PhosphorIconsStyle.fill),
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Time\'s Up!',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Quiz automatically submitted',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
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
                color: Colors.orange.shade600,
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
                  backgroundColor: Colors.orange.shade600,
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
                      setState(() {
                        isTimerRunning = false;
                      });
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
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.categoryTitle,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: remainingSeconds <= 60 
                    ? Colors.red.withOpacity(0.2)
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: remainingSeconds <= 60 
                      ? Colors.red.shade200
                      : Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIcons.timer(PhosphorIconsStyle.fill),
                    color: remainingSeconds <= 60 ? Colors.red.shade100 : Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _formatTime(remainingSeconds),
                    style: GoogleFonts.poppins(
                      color: remainingSeconds <= 60 ? Colors.red.shade100 : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.categoryColor,
                  widget.categoryColor.withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.categoryColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${userAnswers.length}/${questions.length}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade400,
                            Colors.green.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _submitQuiz,
                          borderRadius: BorderRadius.circular(14),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Submit',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final itemsPerRow = 5;
                    final totalRows = (questions.length / itemsPerRow).ceil();
                    final itemSize = (constraints.maxWidth - (itemsPerRow - 1) * 8) / itemsPerRow;
                    
                    return SizedBox(
                      height: (totalRows * itemSize) + ((totalRows - 1) * 8),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: itemsPerRow,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          final isAnswered = userAnswers.containsKey(index);
                          final isCurrent = index == currentQuestionIndex;

                          return GestureDetector(
                            onTap: () => _goToQuestion(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                gradient: isCurrent
                                    ? LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white.withOpacity(0.95),
                                        ],
                                      )
                                    : null,
                                color: isCurrent
                                    ? null
                                    : isAnswered
                                        ? Colors.green.withOpacity(0.3)
                                        : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isCurrent
                                      ? Colors.white
                                      : isAnswered
                                          ? Colors.green.withOpacity(0.5)
                                          : Colors.white.withOpacity(0.3),
                                  width: isCurrent ? 2.5 : 1.5,
                                ),
                                boxShadow: isCurrent
                                    ? [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.5),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${index + 1}',
                                      style: GoogleFonts.poppins(
                                        color: isCurrent
                                            ? widget.categoryColor
                                            : Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (isAnswered && !isCurrent)
                                      const SizedBox(height: 2),
                                    if (isAnswered && !isCurrent)
                                      Icon(
                                        PhosphorIcons.check(PhosphorIconsStyle.bold),
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

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
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.grey.shade50,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: widget.categoryColor.withOpacity(0.2),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.categoryColor.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: widget.categoryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    PhosphorIcons.question(PhosphorIconsStyle.fill),
                                    color: widget.categoryColor,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Question ${index + 1}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: widget.categoryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              question.question,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

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

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _previousQuestion,
                          borderRadius: BorderRadius.circular(18),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.chevron_back,
                                  color: primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Previous',
                                  style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (currentQuestionIndex > 0) const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: currentQuestionIndex < questions.length - 1
                          ? LinearGradient(
                              colors: [primaryColor, primaryColor.withOpacity(0.8)],
                            )
                          : LinearGradient(
                              colors: [Colors.green.shade500, Colors.green.shade700],
                            ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: (currentQuestionIndex < questions.length - 1
                                  ? primaryColor
                                  : Colors.green)
                              .withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: currentQuestionIndex < questions.length - 1
                            ? _nextQuestion
                            : _submitQuiz,
                        borderRadius: BorderRadius.circular(18),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentQuestionIndex < questions.length - 1
                                    ? 'Next'
                                    : 'Submit Quiz',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                currentQuestionIndex < questions.length - 1
                                    ? Ionicons.chevron_forward
                                    : Ionicons.checkmark_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withOpacity(0.15),
                    primaryColor.withOpacity(0.08),
                  ],
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : Colors.grey.shade300,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [primaryColor, primaryColor.withOpacity(0.8)],
                      )
                    : null,
                color: isSelected ? null : Colors.grey.shade100,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + answerIndex),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
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
                  color: isSelected ? primaryColor : Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIcons.check(PhosphorIconsStyle.bold),
                  color: Colors.white,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
