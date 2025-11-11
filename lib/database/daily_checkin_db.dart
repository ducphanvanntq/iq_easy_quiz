import 'package:isar_community/isar.dart';

part 'daily_checkin_db.g.dart';

@collection
class DailyCheckInDb {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime checkInDate;

  late DateTime createdAt;

  @ignore
  bool get isToday {
    final now = DateTime.now();
    return checkInDate.year == now.year &&
        checkInDate.month == now.month &&
        checkInDate.day == now.day;
  }
}

