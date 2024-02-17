import 'package:path/path.dart';
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
    String path = await getDatabasesPath();

    return await openDatabase(
      join(path, 'gymBro.db'),
      onCreate: _createDatabase,
      onUpgrade: null,
      version: 1,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    if (version == 1) {
      await db.execute(SQL_CREATE_TABLE_COMMANDS);

      // Set the user-defined version number to 1 (placeholder for future upgrades)
      await db.execute('PRAGMA user_version = 1');
    } else {
      throw ArgumentError('Database version $version is not supported');
    }
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    Database db = await _instance.database;
    return await db.insert('items', row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await _instance.database;
    return await db.query('items');
  }
}
