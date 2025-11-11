import 'package:isar_community/isar.dart';
import '../database/database.dart';
import '../database/daily_checkin_db.dart';

class CheckinService {
  static Future<List<DailyCheckinDb>> getAllCheckins() async {
    final isar = await IsarDatabase.instance;
    final allIds = await isar.dailyCheckinDbs.where().idProperty().findAll();
    final allCheckins = await isar.dailyCheckinDbs.getAll(allIds);
    
    final validCheckins = allCheckins.where((c) => c != null).cast<DailyCheckinDb>().toList();
    validCheckins.sort((a, b) => b.checkinDate.compareTo(a.checkinDate));
    
    return validCheckins;
  }

  static Future<bool> hasCheckedInToday() async {
    final allCheckins = await getAllCheckins();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return allCheckins.any((c) {
      final checkinDay = DateTime(
        c.checkinDate.year,
        c.checkinDate.month,
        c.checkinDate.day,
      );
      return checkinDay == today;
    });
  }

  static Future<void> checkInToday() async {
    final isar = await IsarDatabase.instance;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final allCheckins = await getAllCheckins();
    final todayCheckin = allCheckins.firstWhere(
      (c) {
        final checkinDay = DateTime(
          c.checkinDate.year,
          c.checkinDate.month,
          c.checkinDate.day,
        );
        return checkinDay == today;
      },
      orElse: () => DailyCheckinDb()..id = 0,
    );

    if (todayCheckin.id == 0) {
      final checkin = DailyCheckinDb()
        ..checkinDate = today
        ..createdAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.dailyCheckinDbs.put(checkin);
      });
    }
  }

  static Future<List<DailyCheckinDb>> getCheckinsForMonth(DateTime month) async {
    final allCheckins = await getAllCheckins();
    
    return allCheckins.where((c) {
      return c.checkinDate.year == month.year &&
          c.checkinDate.month == month.month;
    }).toList()
      ..sort((a, b) => a.checkinDate.compareTo(b.checkinDate));
  }

  static Future<List<DateTime>> getCheckinDatesForMonth(DateTime month) async {
    final checkins = await getCheckinsForMonth(month);
    return checkins.map((c) => c.checkinDate).toList();
  }

  static Future<DailyCheckinDb?> getLastCheckin() async {
    final allCheckins = await getAllCheckins();
    
    if (allCheckins.isEmpty) return null;
    
    return allCheckins.first;
  }

  static Future<int> getTotalCheckins() async {
    final allCheckins = await getAllCheckins();
    return allCheckins.length;
  }

  static Future<Map<String, dynamic>> getCheckinStats() async {
    final totalCheckins = await getTotalCheckins();
    final hasCheckedInToday = await CheckinService.hasCheckedInToday();

    return {
      'totalCheckins': totalCheckins,
      'hasCheckedInToday': hasCheckedInToday,
    };
  }
}

