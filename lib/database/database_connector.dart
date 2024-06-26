import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'create_table_commands.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Restricting DatabaseHelper to only a single instance (singleton)
  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    return await openDatabase(
      join(appDocDir.path, 'GymBro1.db'),
      onCreate: _createDatabase,
      onUpgrade: null,
      version: 1,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    if (version == 1) {
      try {
        // await db.execute(SQL_CREATE_TABLE_COMMANDS);
        for (String command in SQL_CREATE_TABLE_COMMANDS) {
          print("running command");
          await db.execute(command);
        }
      } catch (e) {
        print("epic fail");
        rethrow;
      }

      // Set the user-defined version number to 1 (placeholder for future upgrades)
      await db.execute('PRAGMA user_version = 1');
    } else {
      throw ArgumentError('Database version $version is not supported');
    }
  }
}
