import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FitnessDbHelper {
  static Database? _database;

  static Future<Database?> getDatabase() async{
    if(_database != null) return _database;

    final path = join(await getDatabasesPath(), "fitness.db");
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''
        CREATE TABLE fitness_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        value INTEGER,
        date TEXT
        )
        ''');
      },
    );
    return _database;
  }

  static Future<void> insertData(Map<String, dynamic> fitnessData) async{
    final db = await getDatabase();
    await db?.insert("fitness_data", fitnessData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getWeeklyData(String type) async{
    final db = await getDatabase();
    DateTime now = DateTime.now();
    DateTime weekAgo = now.subtract(const Duration(days: 6));

    String startDate = DateFormat('yyyy-MM-dd').format(weekAgo);
    String endDate = DateFormat('yyyy-MM-dd').format(now);

    return db!.query(
      "fitness_data",
      where: "type = ? AND date BETWEEN ? AND ?",
      whereArgs: [type, startDate, endDate],
      orderBy: "date ASC",
    );
  }
}