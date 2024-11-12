import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'create_table_commands.dart';

String currentDbName = "GymBro1";

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
      join(appDocDir.path, "$currentDbName.db"),
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
        print("epic failL: $e");
        rethrow;
      }

      // Set the user-defined version number to 1 (placeholder for future upgrades)
      await db.execute('PRAGMA user_version = 1');
    } else {
      throw ArgumentError('Database version $version is not supported');
    }
  }

  Future<void> exportDatabaseToDownloads() async {
    // Get the path to the original database
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath =
        '${appDocDir.path}/GymBro1.db'; // Your original database path

    // Get the path to the Downloads folder based on Android version
    String downloadsPath;

    try {
      if (Platform.isAndroid && !kIsWeb) {
        // For Android 10 and above, use scoped storage
        if (Platform.version.contains("29") ||
            Platform.version.contains("30")) {
          // Handle Android 10+ scoped storage, by using the SAF or a shared path.
          // In this example, we'll assume using Scoped Storage API or using a plugin for Downloads access.
          final externalStorageDir = await getExternalStorageDirectory();
          downloadsPath =
              '${externalStorageDir!.path}/Download/GymBro_backup.db';
        } else {
          // For Android 9 and below, we can directly access /storage/emulated/0/Download/
          downloadsPath = '/storage/emulated/0/Download/GymBro_backup.db';
        }
      } else {
        // Handle iOS or other platforms
        downloadsPath = '/storage/emulated/0/Download/GymBro_backup.db';
      }

      // Copy the database to the Downloads folder
      File originalDb = File(dbPath);
      await originalDb.copy(downloadsPath);

      print('Database exported to: $downloadsPath');
    } catch (e) {
      print('error exporting database: $e');
    }
  }

/// Backup the database to an accessible location.
Future<void> backupDatabase() async {
  try {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocDir.path, "$currentDbName.db");  // Path to your current database

    // Get a location to save the backup (e.g., Downloads, Documents, etc.)
    // final backupDir = await getExternalStorageDirectory(); // Can be adjusted depending on platform
    // final backupPath = '${backupDir!.path}/Download/GymBro_backup.db';  // Backup file path
    // Get the path to the Downloads folder
    final externalStorageDir = await getExternalStorageDirectory()!;
    String downloadsPath = '${externalStorageDir!.path}/GymBro1_backup.db';

    // Copy the database to the backup location
    final dbFile = File(dbPath);
    await dbFile.copy(downloadsPath);

    print('Database backup successful: $downloadsPath');
  } catch (e) {
    print('Error backing up database: $e');
  }
}
}
