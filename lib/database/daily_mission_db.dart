import 'package:isar_community/isar.dart';

part 'daily_mission_db.g.dart';

@collection
class DailyMissionDb {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime missionDate;

  late String categoryId;
  late String categoryTitle;
  late String difficulty;

  late bool isCompleted;
  
  DateTime? completedAt;
  
  late DateTime createdAt;

  @ignore
  bool get isToday {
    final now = DateTime.now();
    return missionDate.year == now.year &&
        missionDate.month == now.month &&
        missionDate.day == now.day;
  }

  @ignore
  String get rewardPoints {
    switch (difficulty) {
      case 'easy':
        return '3';
      case 'medium':
        return '5';
      case 'hard':
        return '8';
      default:
        return '3';
    }
  }
}
