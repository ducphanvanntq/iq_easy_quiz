import 'package:isar_community/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database.dart';
import '../database/daily_checkin_db.dart';
import 'mission_service.dart';

class CheckInService {
  static Future<List<DailyCheckInDb>> getAllCheckIns() async {
    final isar = await IsarDatabase.instance;
    final allIds = await isar.dailyCheckInDbs.where().idProperty().findAll();
    final allCheckIns = await isar.dailyCheckInDbs.getAll(allIds);
    
    final validCheckIns = allCheckIns.where((c) => c != null).cast<DailyCheckInDb>().toList();
    validCheckIns.sort((a, b) => b.checkInDate.compareTo(a.checkInDate));
    
    return validCheckIns;
  }

  static Future<bool> hasCheckedInToday() async {
    final allCheckIns = await getAllCheckIns();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return allCheckIns.any((c) {
      final checkInDay = DateTime(
        c.checkInDate.year,
        c.checkInDate.month,
        c.checkInDate.day,
      );
      return checkInDay == today;
    });
  }

  static Future<void> checkInToday() async {
    final isar = await IsarDatabase.instance;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final allCheckIns = await getAllCheckIns();
    final todayCheckIn = allCheckIns.firstWhere(
      (c) {
        final checkInDay = DateTime(
          c.checkInDate.year,
          c.checkInDate.month,
          c.checkInDate.day,
        );
        return checkInDay == today;
      },
      orElse: () => DailyCheckInDb()..id = 0,
    );

    if (todayCheckIn.id == 0) {
      final checkIn = DailyCheckInDb()
        ..checkInDate = today
        ..createdAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.dailyCheckInDbs.put(checkIn);
      });
      
      final prefs = await SharedPreferences.getInstance();
      final currentPoints = prefs.getInt('userPoints') ?? 0;
      await prefs.setInt('userPoints', currentPoints + 5);
      
      await MissionService.cleanOldMissions();
      await MissionService.generateTodayMissions();
    }
  }

  static Future<List<DailyCheckInDb>> getCheckInsForMonth(DateTime month) async {
    final allCheckIns = await getAllCheckIns();
    
    return allCheckIns.where((c) {
      return c.checkInDate.year == month.year &&
          c.checkInDate.month == month.month;
    }).toList()
      ..sort((a, b) => a.checkInDate.compareTo(b.checkInDate));
  }

  static Future<List<DateTime>> getCheckInDatesForMonth(DateTime month) async {
    final checkIns = await getCheckInsForMonth(month);
    return checkIns.map((c) => c.checkInDate).toList();
  }

  static Future<DailyCheckInDb?> getLastCheckIn() async {
    final allCheckIns = await getAllCheckIns();
    
    if (allCheckIns.isEmpty) return null;
    
    return allCheckIns.first;
  }

  static Future<int> getTotalCheckIns() async {
    final allCheckIns = await getAllCheckIns();
    return allCheckIns.length;
  }

  static Future<Map<String, dynamic>> getCheckInStats() async {
    final totalCheckIns = await getTotalCheckIns();
    final hasCheckedInToday = await CheckInService.hasCheckedInToday();

    return {
      'totalCheckIns': totalCheckIns,
      'hasCheckedInToday': hasCheckedInToday,
    };
  }
}

