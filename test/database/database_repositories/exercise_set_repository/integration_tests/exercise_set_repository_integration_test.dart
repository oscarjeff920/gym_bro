import 'package:flutter_test/flutter_test.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_helper.dart';
import 'package:gym_bro/database/database_repositories/exercise_set_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'mock_data_sets.dart';

void main() {
  late Database database;
  late ExerciseSetRepository exerciseSetRepository;

  setUp(() async {
    sqfliteFfiInit(); // Ensure ffi is initialized.
    databaseFactory = databaseFactoryFfi; // Initialize databaseFactory
    database = await openDatabase(inMemoryDatabasePath);
    DatabaseHelper databaseHelper = DatabaseHelper();

    exerciseSetRepository = ExerciseSetRepository(databaseHelper);

    await databaseHelper.runCreateDbCommands(dbConnection: database);
  });

  tearDown(() async {
    await database.close();
  });

  group('Integration tests for getLatestExercisesByMovementId', () {
    test('Retrieves entries with matching movement ID', () async {
      mockData1.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });

      int movementId = 0;

      List<Map<String, dynamic>> returnedResult = await exerciseSetRepository
          .queryLatestExercisesByMovementId(movementId, database);

      for (var returnedData in returnedResult) {
        expect(returnedData['movement_id'], movementId);
      }
    });
    test('Retrieves entries from newest (most recent) to oldest', () async {
      mockData1.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });

      int movementId = 1;

      List<Map<String, dynamic>> returnedResult = await exerciseSetRepository
          .queryLatestExercisesByMovementId(movementId, database);

      DateTime? previousWorkoutDate;
      DateTime currentWorkoutDate;
      bool isFirstIteration = true;

      for (var returnedData in returnedResult) {
        currentWorkoutDate = DateTime(
            returnedData['year'], returnedData['month'], returnedData['day']);
        if (isFirstIteration) {
          isFirstIteration = false;
          previousWorkoutDate = currentWorkoutDate;
          continue;
        } else {
          // the previous workout happened after the current one
          bool isOlder = previousWorkoutDate!.isAfter(currentWorkoutDate);
          expect(isOlder, true);
          previousWorkoutDate = currentWorkoutDate;
        }
      }
    });
    test('Retrieves exactly 10 entries', () async {
      mockData1.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });

      List<Map<String, dynamic>> allExercises =
          await database.query(exerciseTableName, orderBy: 'id DESC');

      int movementId = 1;

      List<Map<String, dynamic>> returnedResult = await exerciseSetRepository
          .queryLatestExercisesByMovementId(movementId, database);

      expect(returnedResult.length, 10);
    });
    test('Retrieves exactly 2 entries', () async {
      mockData1.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });

      int movementId = 0;

      List<Map<String, dynamic>> returnedResult = await exerciseSetRepository
          .queryLatestExercisesByMovementId(movementId, database);

      expect(returnedResult.length, 2);
    });
  });
  group('Integration tests for getExerciseSetsByExerciseId', () {
    test('each exercise_id returns the correct number of entries', () async {
      mockData2.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });
      List<Map<String, dynamic>> exerciseIdIs0Results =
          await exerciseSetRepository.queryExerciseSetsByExerciseId(0, database);
      expect(exerciseIdIs0Results.length, 7);

      List<Map<String, dynamic>> exerciseIdIs1Results =
          await exerciseSetRepository.queryExerciseSetsByExerciseId(1, database);
      expect(exerciseIdIs1Results.length, 2);

      List<Map<String, dynamic>> exerciseIdIs2Results =
          await exerciseSetRepository.queryExerciseSetsByExerciseId(2, database);
      expect(exerciseIdIs2Results.length, 5);
    });
    test('Retrieves entries with matching exercise ID', () async {
      mockData2.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });

      int exerciseId = 0;

      List<Map<String, dynamic>> returnedResults = await exerciseSetRepository
          .queryExerciseSetsByExerciseId(exerciseId, database);

      for (var result in returnedResults) {
        expect(result['exercise_id'], exerciseId);
      }
    });
    test('each exercise_id returns the correct number of entries', () async {
      mockData2.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });
      List<Map<String, dynamic>> exerciseIdIs0Results =
          await exerciseSetRepository.queryExerciseSetsByExerciseId(0, database);
      expect(exerciseIdIs0Results.length, 7);

      List<Map<String, dynamic>> exerciseIdIs1Results =
          await exerciseSetRepository.queryExerciseSetsByExerciseId(1, database);
      expect(exerciseIdIs1Results.length, 2);

      List<Map<String, dynamic>> exerciseIdIs2Results =
          await exerciseSetRepository.queryExerciseSetsByExerciseId(2, database);
      expect(exerciseIdIs2Results.length, 5);
    });
  });
  group('Integration tests for getLastPRSessionsByMovementId', () {
    test('query returns the first instance of PR', () async {
      mockData3.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });
      List<Map<String, dynamic>> returnFirstInstanceOfPR =
          await exerciseSetRepository.queryDistinctPRSetsByMovementId(
              1, database);
      expect(returnFirstInstanceOfPR.length, 1);
      expect(returnFirstInstanceOfPR.firstOrNull, {
        'weight': 60,
        'reps': 2,
        'extra_reps': null,
        'set_order': 2,
        'year': 2024,
        'month': 3,
        'day': 4,
        'start_time': null,
        'movement_id': 1,
        'workout_id': 1,
        'exercise_id': 1,
        'exercise_set_id': 1,
      });
    });
    test('query returns empty for movement_id that does not exist', () async {
      mockData3.forEach((table, data) {
        for (final insertData in data) {
          database.insert(table, insertData);
        }
      });
      List<Map<String, dynamic>> returnFirstInstanceOfPR =
          await exerciseSetRepository.queryDistinctPRSetsByMovementId(
              10, database);
      expect(returnFirstInstanceOfPR.length, 0);
    });
  });
}
