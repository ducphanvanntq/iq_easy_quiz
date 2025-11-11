import 'dart:math';
import 'package:isar_community/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database.dart';
import '../database/daily_mission_db.dart';
import '../data/quiz_categories.dart';

class MissionService {
  static Future<List<DailyMissionDb>> getTodayMissions() async {
    final isar = await IsarDatabase.instance;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final allIds = await isar.dailyMissionDbs.where().idProperty().findAll();
    final allMissions = await isar.dailyMissionDbs.getAll(allIds);
    
    final validMissions = allMissions.where((m) => m != null).cast<DailyMissionDb>().toList();
    
    final todayMissions = validMissions.where((m) {
      final missionDay = DateTime(
        m.missionDate.year,
        m.missionDate.month,
        m.missionDate.day,
      );
      return missionDay == today;
    }).toList();

    todayMissions.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    
    return todayMissions;
  }

  static Future<void> generateTodayMissions() async {
    final existingMissions = await getTodayMissions();
    
    if (existingMissions.isNotEmpty) {
      return;
    }

    final isar = await IsarDatabase.instance;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final random = Random();

    final difficulties = ['easy', 'medium', 'hard'];
    
    final selectedCategories = <int>{};
    while (selectedCategories.length < 3) {
      selectedCategories.add(random.nextInt(quizCategories.length));
    }

    final missions = <DailyMissionDb>[];
    
    for (var i = 0; i < 3; i++) {
      final categoryIndex = selectedCategories.elementAt(i);
      final category = quizCategories[categoryIndex];
      final difficulty = difficulties[i];
      
      final mission = DailyMissionDb()
        ..missionDate = today
        ..categoryId = category.id
        ..categoryTitle = category.title
        ..difficulty = difficulty
        ..isCompleted = false
        ..createdAt = DateTime.now();
      
      missions.add(mission);
    }

    await isar.writeTxn(() async {
      await isar.dailyMissionDbs.putAll(missions);
    });
  }

  static Future<DailyMissionDb?> checkAndCompleteMission({
    required String categoryId,
    required String difficulty,
  }) async {
    final todayMissions = await getTodayMissions();
    
    final matchingMission = todayMissions.firstWhere(
      (m) => 
        m.categoryId == categoryId && 
        m.difficulty == difficulty && 
        !m.isCompleted,
      orElse: () => DailyMissionDb()..id = 0,
    );

    if (matchingMission.id == 0) {
      return null;
    }

    final isar = await IsarDatabase.instance;
    
    matchingMission.isCompleted = true;
    matchingMission.completedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.dailyMissionDbs.put(matchingMission);
    });

    final prefs = await SharedPreferences.getInstance();
    final currentPoints = prefs.getInt('userPoints') ?? 0;
    final rewardPoints = int.parse(matchingMission.rewardPoints);
    await prefs.setInt('userPoints', currentPoints + rewardPoints);

    return matchingMission;
  }

  static Future<Map<String, dynamic>> getMissionStats() async {
    final todayMissions = await getTodayMissions();
    final completedCount = todayMissions.where((m) => m.isCompleted).length;
    final totalCount = todayMissions.length;

    return {
      'completedCount': completedCount,
      'totalCount': totalCount,
      'hasMissions': totalCount > 0,
      'allCompleted': totalCount > 0 && completedCount == totalCount,
    };
  }

  static Future<void> cleanOldMissions() async {
    final isar = await IsarDatabase.instance;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final allIds = await isar.dailyMissionDbs.where().idProperty().findAll();
    final allMissions = await isar.dailyMissionDbs.getAll(allIds);
    
    final validMissions = allMissions.where((m) => m != null).cast<DailyMissionDb>().toList();
    
    final oldMissions = validMissions.where((m) {
      final missionDay = DateTime(
        m.missionDate.year,
        m.missionDate.month,
        m.missionDate.day,
      );
      return missionDay.isBefore(today);
    }).toList();

    if (oldMissions.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.dailyMissionDbs.deleteAll(oldMissions.map((m) => m.id).toList());
      });
    }
  }
}
