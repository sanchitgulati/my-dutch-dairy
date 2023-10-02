import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'journal.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> init() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'dairy3.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
          CREATE TABLE dairy (
            id INTEGER PRIMARY KEY,
            millisecondsSinceEpoch INT,
            heading TEXT,
            text TEXT
          )
          """,
        );
      },
      version: 2,
    );
  }

  Future<int> insert(Journal entry) async {
    int result = await db.insert('dairy', entry.toMap());
    return result;
  }

  Future<int> update(Journal user) async {
    int result = await db.update(
      'dairy',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
    return result;
  }

  Future<List<Journal>> retrieve() async {
    final List<Map<String, Object?>> queryResult = await db.query('dairy');
    return queryResult.map((e) => Journal.fromMap(e)).toList();
  }

  Future<void> delete(int id) async {
    await db.delete(
      'dairy',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
