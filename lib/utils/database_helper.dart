import 'dart:io';
// import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(documentsDirectory.path, "light_db.sqlite");

    // Check if the database exists
    var exists = await databaseExists(dbPath);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(path.dirname(dbPath)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(path.join("assets", "light_db.sqlite"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(dbPath).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    // Open the database
    return await openDatabase(dbPath, readOnly: true);
  }

  Future<List<Map<String, dynamic>>> searchChinese(String query) async {
    Database db = await database;
    return await db.query(
      'dictionaries',
      where: 'chinese LIKE ?',
      whereArgs: ['%$query%'],
      limit: 20, // Limit results to 20 for performance
    );
  }
}
