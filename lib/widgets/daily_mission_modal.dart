import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../services/mission_service.dart';
import '../database/daily_mission_db.dart';

class DailyMissionModal extends StatefulWidget {
  const DailyMissionModal({super.key});

  @override
  State<DailyMissionModal> createState() => _DailyMissionModalState();
}

class _DailyMissionModalState extends State<DailyMissionModal> {
  static const Color primaryColor = Color(0xFF06A8E8);
  static const Color secondaryColor = Color(0xFF00C9D7);

  List<DailyMissionDb> missions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMissions();
  }

  Future<void> _loadMissions() async {
    setState(() {
      isLoading = true;
    });

    final todayMissions = await MissionService.getTodayMissions();

    setState(() {
      missions = todayMissions;
      isLoading = false;
    });
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return PhosphorIcons.smiley(PhosphorIconsStyle.fill);
      case 'medium':
        return PhosphorIcons.lightbulb(PhosphorIconsStyle.fill);
      case 'hard':
        return PhosphorIcons.fire(PhosphorIconsStyle.fill);
      default:
        return PhosphorIcons.question(PhosphorIconsStyle.fill);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        constraints: const BoxConstraints(maxHeight: 400),
        padding: const EdgeInsets.all(24),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final completedCount = missions.where((m) => m.isCompleted).length;

    return Container(
      constraints: const BoxConstraints(maxHeight: 500),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, secondaryColor],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    PhosphorIcons.target(PhosphorIconsStyle.fill),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Missions',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$completedCount/${missions.length} completed',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Today',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: missions.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PhosphorIcons.clipboardText(PhosphorIconsStyle.regular),
                          size: 48,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No missions yet',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Check in to get daily missions!',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: missions.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return _buildMissionItem(missions[index], index + 1);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionItem(DailyMissionDb mission, int number) {
    final difficultyColor = _getDifficultyColor(mission.difficulty);
    final difficultyIcon = _getDifficultyIcon(mission.difficulty);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: mission.isCompleted
            ? Colors.green.withOpacity(0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: mission.isCompleted
              ? Colors.green.withOpacity(0.3)
              : Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: mission.isCompleted
                ? Colors.green.withOpacity(0.08)
                : Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: mission.isCompleted
                  ? Colors.green.withOpacity(0.15)
                  : difficultyColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: mission.isCompleted
                ? Icon(
                    PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                    color: Colors.green,
                    size: 20,
                  )
                : Center(
                    child: Text(
                      '$number',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: difficultyColor,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mission.categoryTitle,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                          decoration: mission.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: Colors.grey.shade400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            difficultyIcon,
                            color: difficultyColor,
                            size: 10,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            mission.difficulty.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: difficultyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.coins(PhosphorIconsStyle.fill),
                      size: 12,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${mission.rewardPoints} pts',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.amber.shade800,
                      ),
                    ),
                    if (mission.isCompleted) ...[
                      const SizedBox(width: 8),
                      Icon(
                        PhosphorIcons.check(PhosphorIconsStyle.bold),
                        size: 12,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Completed',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
