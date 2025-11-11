import 'package:isar_community/isar.dart';

part 'daily_checkin_db.g.dart';

@collection
class DailyCheckinDb {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime checkinDate;

  late DateTime createdAt;

  @ignore
  bool get isToday {
    final now = DateTime.now();
    return checkinDate.year == now.year &&
        checkinDate.month == now.month &&
        checkinDate.day == now.day;
  }
}

