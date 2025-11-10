import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'quiz_history_db.dart';

class IsarDatabase {
  static final IsarDatabase _instance = IsarDatabase._internal();
  factory IsarDatabase() => _instance;
  IsarDatabase._internal();

  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }
    _isar = await _initIsar();
    return _isar!;
  }

  static Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [QuizHistoryDbSchema],
      directory: dir.path,
      name: 'quiz_database',
      inspector: true,
    );
  }

  static Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}

