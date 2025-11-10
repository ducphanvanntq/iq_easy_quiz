import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'User';
    });
  }

  final List<QuizCategory> categories = [
    QuizCategory(
      title: 'Mathematics',
      description: 'Test your math skills',
      icon: PhosphorIcons.mathOperations(PhosphorIconsStyle.fill),
      color: const Color(0xFF6C5CE7),
      questionCount: 25,
    ),
    QuizCategory(
      title: 'Science',
      description: 'Explore scientific knowledge',
      icon: PhosphorIcons.atom(PhosphorIconsStyle.fill),
      color: const Color(0xFF00B894),
      questionCount: 30,
    ),
    QuizCategory(
      title: 'History',
      description: 'Journey through time',
      icon: PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.fill),
      color: const Color(0xFFE17055),
      questionCount: 20,
    ),
    QuizCategory(
      title: 'Geography',
      description: 'Discover the world',
      icon: PhosphorIcons.globe(PhosphorIconsStyle.fill),
      color: const Color(0xFF0984E3),
      questionCount: 28,
    ),
    QuizCategory(
      title: 'Literature',
      description: 'Books and authors',
      icon: PhosphorIcons.book(PhosphorIconsStyle.fill),
      color: const Color(0xFFD63031),
      questionCount: 22,
    ),
    QuizCategory(
      title: 'Technology',
      description: 'Digital world quiz',
      icon: PhosphorIcons.cpu(PhosphorIconsStyle.fill),
      color: const Color(0xFF00CEC9),
      questionCount: 35,
    ),
    QuizCategory(
      title: 'Sports',
      description: 'Athletic knowledge',
      icon: PhosphorIcons.soccerBall(PhosphorIconsStyle.fill),
      color: const Color(0xFFFD79A8),
      questionCount: 18,
    ),
    QuizCategory(
      title: 'Music',
      description: 'Musical genius test',
      icon: PhosphorIcons.musicNotes(PhosphorIconsStyle.fill),
      color: const Color(0xFFFDCB6E),
      questionCount: 24,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primaryColor, secondaryColor],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ionicons.hand_right,
                              color: Colors.white.withOpacity(0.9),
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Hello, $userName!',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose a category to start',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = categories[index];
                  return _buildCategoryCard(category);
                },
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(QuizCategory category) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${category.title} - Coming soon!'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: category.color,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.icon,
                size: 48,
                color: category.color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              category.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Ionicons.help_circle,
                    size: 14,
                    color: category.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${category.questionCount} questions',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: category.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizCategory {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int questionCount;

  QuizCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.questionCount,
  });
}

