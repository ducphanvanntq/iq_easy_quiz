import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz_screen.dart';
import 'add_question_screen.dart';
import 'data/quiz_categories.dart';
import 'services/checkin_service.dart';
import 'services/mission_service.dart';
import 'widgets/daily_checkin_modal.dart';
import 'widgets/daily_mission_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);
  String userName = '';
  int completedMissions = 0;
  int totalMissions = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _checkDailyCheckIn();
    _loadMissionStats();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'User';
    });
  }

  Future<void> _checkDailyCheckIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final hasCheckedIn = await CheckInService.hasCheckedInToday();
    
    if (!hasCheckedIn && mounted) {
      _showCheckInModal();
    }
  }

  Future<void> _loadMissionStats() async {
    final stats = await MissionService.getMissionStats();
    setState(() {
      completedMissions = stats['completedCount'] ?? 0;
      totalMissions = stats['totalCount'] ?? 0;
    });
  }

  void _showCheckInModal() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: const DailyCheckInModal(),
      ),
    );
    _loadMissionStats();
  }

  void _showMissionModal() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: const DailyMissionModal(),
      ),
    );
    _loadMissionStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddQuestionScreen(),
            ),
          );
        },
        backgroundColor: primaryColor,
        icon: Icon(
          PhosphorIcons.plus(PhosphorIconsStyle.bold),
          color: Colors.white,
        ),
        label: Text(
          'Add Question',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: false,
            pinned: true,
            backgroundColor: primaryColor,
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.listChecks(PhosphorIconsStyle.fill),
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: _showMissionModal,
                    tooltip: 'Daily Missions',
                  ),
                  if (totalMissions > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: completedMissions == totalMissions
                              ? Colors.green
                              : Colors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Center(
                          child: Text(
                            '$completedMissions/$totalMissions',
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                icon: Icon(
                  PhosphorIcons.calendarCheck(PhosphorIconsStyle.fill),
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: _showCheckInModal,
                tooltip: 'Check-In History',
              ),
            ],
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
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ionicons.hand_right,
                              color: Colors.white.withOpacity(0.9),
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Hello, $userName!',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Choose a category to start your quiz',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
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
                  final category = quizCategories[index];
                  return _buildCategoryCard(category);
                },
                childCount: quizCategories.length,
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
