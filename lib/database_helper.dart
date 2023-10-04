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
      join(path, 'dairy6.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
          CREATE TABLE dairy (
            id TEXT PRIMARY KEY,
            millisecondsSinceEpoch INT,
            heading TEXT,
            text TEXT
          )
          """,
        );
        await database.execute('''
          CREATE TABLE IF NOT EXISTS inventory (
            id INTEGER PRIMARY KEY,
            isUsed INTEGER
          )
      ''');
        for (int i = 1; i <= 100; i++) {
          await database.insert('inventory', {'id': i, 'isUsed': 0});
        }
      },
      version: 1,
    );
  }

  Future<void> insertOrUpdate(Journal entry) async {
    // Check if the entry with the same text already exists in the 'dairy' table.
    List<Map<String, dynamic>> existingRecords = await db.query(
      'dairy',
      where: 'text = ?',
      whereArgs: [entry.text],
    );

    if (existingRecords.isNotEmpty) {
      // Update the existing record with the new data.
      await db.update(
        'dairy',
        entry.toMap(),
        where: 'id = ?',
        whereArgs: [existingRecords.first['id']],
      );
    } else {
      // Insert a new record if no matching text is found.
      await db.insert('dairy', entry.toMap());
    }
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
    final List<Map<String, Object?>> queryResult = await db
        .rawQuery('SELECT * FROM dairy ORDER BY millisecondsSinceEpoch DESC');
    return queryResult.map((e) => Journal.fromMap(e)).toList();
  }

  Future<void> delete(String id) async {
    await db.delete(
      'dairy',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Function to retrieve content for a given ID
  Future<Journal?> retrieveById(int id) async {
    List<Map<String, Object?>> result = await db.query(
      'dairy',
      where: "id = ?",
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Journal.fromMap(result.first);
    } else {
      return null;
    }
  }

  // Function to get a random inventory ID that isn't already used or is the least used
  Future<int?> getRandomInventoryId() async {
    // Get a random ID that isn't already used orleast used
    List<Map<String, Object?>> leastUsedId = await db.rawQuery('''
        SELECT id FROM (SELECT id FROM inventory ORDER BY isUsed ASC LIMIT 10) ORDER BY RANDOM() LIMIT 1
      ''');

    if (leastUsedId.isNotEmpty) {
      int id = leastUsedId.first['id'] as int;
      // Mark the least used ID as used by incrementing isUsed by 1
      await db.rawUpdate('''
        UPDATE inventory SET isUsed = isUsed + 1 WHERE id = ?
      ''', [id]);
      return id;
    } else {
      // No IDs available
      return null;
    }
  }
}
