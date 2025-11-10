import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_screen.dart';

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
      id: 'any',
      title: 'Any Category',
      description: 'Random questions',
      icon: PhosphorIcons.shuffleAngular(PhosphorIconsStyle.fill),
      color: const Color(0xFF6C5CE7),
    ),
    QuizCategory(
      id: '9',
      title: 'General Knowledge',
      description: 'Test your general knowledge',
      icon: PhosphorIcons.brain(PhosphorIconsStyle.fill),
      color: const Color(0xFF00B894),
    ),
    QuizCategory(
      id: '10',
      title: 'Books',
      description: 'Entertainment: Books',
      icon: PhosphorIcons.book(PhosphorIconsStyle.fill),
      color: const Color(0xFFE17055),
    ),
    QuizCategory(
      id: '11',
      title: 'Film',
      description: 'Entertainment: Film',
      icon: PhosphorIcons.filmSlate(PhosphorIconsStyle.fill),
      color: const Color(0xFF0984E3),
    ),
    QuizCategory(
      id: '12',
      title: 'Music',
      description: 'Entertainment: Music',
      icon: PhosphorIcons.musicNotes(PhosphorIconsStyle.fill),
      color: const Color(0xFFD63031),
    ),
    QuizCategory(
      id: '13',
      title: 'Musicals & Theatres',
      description: 'Entertainment',
      icon: PhosphorIcons.maskHappy(PhosphorIconsStyle.fill),
      color: const Color(0xFF00CEC9),
    ),
    QuizCategory(
      id: '14',
      title: 'Television',
      description: 'Entertainment: TV',
      icon: PhosphorIcons.television(PhosphorIconsStyle.fill),
      color: const Color(0xFFFD79A8),
    ),
    QuizCategory(
      id: '15',
      title: 'Video Games',
      description: 'Entertainment: Gaming',
      icon: PhosphorIcons.gameController(PhosphorIconsStyle.fill),
      color: const Color(0xFFFDCB6E),
    ),
    QuizCategory(
      id: '16',
      title: 'Board Games',
      description: 'Entertainment',
      icon: PhosphorIcons.diceFive(PhosphorIconsStyle.fill),
      color: const Color(0xFFA29BFE),
    ),
    QuizCategory(
      id: '17',
      title: 'Science & Nature',
      description: 'Natural sciences',
      icon: PhosphorIcons.atom(PhosphorIconsStyle.fill),
      color: const Color(0xFF55EFC4),
    ),
    QuizCategory(
      id: '18',
      title: 'Computers',
      description: 'Science: Computers',
      icon: PhosphorIcons.desktop(PhosphorIconsStyle.fill),
      color: const Color(0xFF74B9FF),
    ),
    QuizCategory(
      id: '19',
      title: 'Mathematics',
      description: 'Science: Mathematics',
      icon: PhosphorIcons.mathOperations(PhosphorIconsStyle.fill),
      color: const Color(0xFFFF7675),
    ),
    QuizCategory(
      id: '20',
      title: 'Mythology',
      description: 'Ancient myths & legends',
      icon: PhosphorIcons.lightning(PhosphorIconsStyle.fill),
      color: const Color(0xFFFAB1A0),
    ),
    QuizCategory(
      id: '21',
      title: 'Sports',
      description: 'Athletic knowledge',
      icon: PhosphorIcons.soccerBall(PhosphorIconsStyle.fill),
      color: const Color(0xFF81ECEC),
    ),
    QuizCategory(
      id: '22',
      title: 'Geography',
      description: 'Discover the world',
      icon: PhosphorIcons.globe(PhosphorIconsStyle.fill),
      color: const Color(0xFFDFE6E9),
    ),
    QuizCategory(
      id: '23',
      title: 'History',
      description: 'Journey through time',
      icon: PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.fill),
      color: const Color(0xFFFF6348),
    ),
    QuizCategory(
      id: '24',
      title: 'Politics',
      description: 'Political knowledge',
      icon: PhosphorIcons.gavel(PhosphorIconsStyle.fill),
      color: const Color(0xFF2D3436),
    ),
    QuizCategory(
      id: '25',
      title: 'Art',
      description: 'Artistic knowledge',
      icon: PhosphorIcons.palette(PhosphorIconsStyle.fill),
      color: const Color(0xFFE17055),
    ),
    QuizCategory(
      id: '26',
      title: 'Celebrities',
      description: 'Famous people',
      icon: PhosphorIcons.star(PhosphorIconsStyle.fill),
      color: const Color(0xFFFDCB6E),
    ),
    QuizCategory(
      id: '27',
      title: 'Animals',
      description: 'Wildlife & pets',
      icon: PhosphorIcons.dog(PhosphorIconsStyle.fill),
      color: const Color(0xFF00B894),
    ),
    QuizCategory(
      id: '28',
      title: 'Vehicles',
      description: 'Cars, planes & more',
      icon: PhosphorIcons.car(PhosphorIconsStyle.fill),
      color: const Color(0xFF636E72),
    ),
    QuizCategory(
      id: '29',
      title: 'Comics',
      description: 'Entertainment: Comics',
      icon: PhosphorIcons.bookOpen(PhosphorIconsStyle.fill),
      color: const Color(0xFFFF7675),
    ),
    QuizCategory(
      id: '30',
      title: 'Gadgets',
      description: 'Science: Gadgets',
      icon: PhosphorIcons.cpu(PhosphorIconsStyle.fill),
      color: const Color(0xFF74B9FF),
    ),
    QuizCategory(
      id: '31',
      title: 'Anime & Manga',
      description: 'Japanese entertainment',
      icon: Ionicons.sparkles,
      color: const Color(0xFFFD79A8),
    ),
    QuizCategory(
      id: '32',
      title: 'Cartoons & Animations',
      description: 'Animated entertainment',
      icon: PhosphorIcons.smiley(PhosphorIconsStyle.fill),
      color: const Color(0xFFA29BFE),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
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
                            Expanded(
                              child: Text(
                                'Hello, $userName!',
                                style: GoogleFonts.poppins(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose a category to start your quiz',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
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
                childAspectRatio: 0.9,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
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

  void _showDifficultyDialog(QuizCategory category) {
    String? selectedDifficulty;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    category.icon,
                    color: category.color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        'Select difficulty level',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
                const SizedBox(height: 24),
                _buildDifficultyOption(
                  title: 'Easy',
                  description: 'Perfect for beginners',
                  icon: PhosphorIcons.smiley(PhosphorIconsStyle.fill),
                  color: Colors.green,
                  difficulty: 'easy',
                  isSelected: selectedDifficulty == 'easy',
                  onTap: () {
                    setState(() {
                      selectedDifficulty = 'easy';
                    });
                  },
                ),
                const SizedBox(height: 12),
                _buildDifficultyOption(
                  title: 'Medium',
                  description: 'A good challenge',
                  icon: PhosphorIcons.lightbulb(PhosphorIconsStyle.fill),
                  color: Colors.orange,
                  difficulty: 'medium',
                  isSelected: selectedDifficulty == 'medium',
                  onTap: () {
                    setState(() {
                      selectedDifficulty = 'medium';
                    });
                  },
                ),
                const SizedBox(height: 12),
                _buildDifficultyOption(
                  title: 'Hard',
                  description: 'For the experts',
                  icon: PhosphorIcons.fire(PhosphorIconsStyle.fill),
                  color: Colors.red,
                  difficulty: 'hard',
                  isSelected: selectedDifficulty == 'hard',
                  onTap: () {
                    setState(() {
                      selectedDifficulty = 'hard';
                    });
                  },
                ),
                const SizedBox(height: 24),
                if (selectedDifficulty != null)
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              categoryId: category.id,
                              categoryTitle: category.title,
                              difficulty: selectedDifficulty!,
                              categoryColor: category.color,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIcons.play(PhosphorIconsStyle.fill),
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Start Quiz',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyOption({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String difficulty,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(isSelected ? 0.2 : 0.1),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIcons.check(PhosphorIconsStyle.bold),
                  color: Colors.white,
                  size: 20,
                ),
              )
            else
              Icon(
                PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(QuizCategory category) {
    return GestureDetector(
      onTap: () => _showDifficultyDialog(category),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: category.color.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.icon,
                size: 40,
                color: category.color,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                category.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                category.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizCategory {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  QuizCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
