import 'dart:core';

import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_helper.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../../data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';

class ExerciseSetRepository {
  final DatabaseHelper databaseHelper;

  ExerciseSetRepository(this.databaseHelper);

  Future<List<Map<String, dynamic>>> getLatestExerciseSetsByMovementIdWrapper(
      int movementId) async {
    final db = await databaseHelper.database;

    List<Map<String, dynamic>> returnData = [];

    List<Map<String, dynamic>> latestExercises =
        await queryLatestExercisesByMovementId(movementId, db);

    if (latestExercises.isEmpty) return returnData;

    for (var exerciseData in latestExercises) {
      List<Map<String, dynamic>> exerciseSetsData =
          await queryExerciseSetsByExerciseId(exerciseData['id'], db);

      returnData.add({
        'sets': exerciseSetsData,
        'year': exerciseData['year'],
        'month': exerciseData['month'],
        'day': exerciseData['day'],
      });
    }

    return returnData;
  }

  // Future<List<Map<String, dynamic>>> getComparisonSetsByMovementIdWrapper(
  //     int movementId, bool isPr) async {
  //   final db = await databaseHelper.database;
  //
  //   final comparisonExerciseSessionsQueryMethod;
  //   final comparisonExerciseSetsQueryMethod;
  //   if (isPr) {
  //     comparisonExerciseSessionsQueryMethod = getLastPRSessionsByMovementId;
  //     comparisonExerciseSetsQueryMethod =
  //   }
  //
  //
  //   List<Map<String, dynamic>> returnData = [];
  //
  //   List<Map<String, dynamic>> returnComparisonExerciseSessions = isPr
  //       ? await getLastPRsByMovementId(movementId, db)
  //       : await getLatestExercisesByMovementId(movementId, db);
  //
  //   if (returnComparisonExerciseSessions.isEmpty) return returnData;
  //
  //   for (var exerciseData in returnComparisonExerciseSessions) {
  //     List<Map<String, dynamic>> exerciseSetsData =
  //         await getExerciseSetsByExerciseId(exerciseData['id'], db);
  //
  //     returnData.add({
  //       'sets': exerciseSetsData,
  //       'year': exerciseData['year'],
  //       'month': exerciseData['month'],
  //       'day': exerciseData['day'],
  //     });
  //   }
  //
  //   return returnData;
  // }

  Future<List<Map<String, dynamic>>> queryLatestExercisesByMovementId(
      int movementId, dbConnection) async {
    // TODO: This currently doesn't order by time, just date..
    String queryMostRecentExerciseByMovementIdString = """
      SELECT 
        $exerciseTableName.id,
        $exerciseTableName.movement_id,
        $exerciseTableName.workout_id,
        $workoutTableName.year,
        $workoutTableName.month,
        $workoutTableName.day
      FROM $exerciseTableName
      JOIN $workoutTableName ON 
        $exerciseTableName.workout_id = $workoutTableName.id
      WHERE $exerciseTableName.movement_id = $movementId
      ORDER BY 
        $workoutTableName.year DESC, 
        $workoutTableName.month DESC, 
        $workoutTableName.day DESC
      LIMIT 10;
      """;
    List<Map<String, dynamic>> latestExercises =
        await dbConnection.rawQuery(queryMostRecentExerciseByMovementIdString);

    return latestExercises;
  }

  Future<List<Map<String, dynamic>>> queryExerciseSetsByExerciseId(
      int exerciseId, dbConnection) async {
    final List<Map<String, dynamic>> exerciseSetsByMovementId =
        await dbConnection.query(
      exerciseSetTableName,
      where: 'exercise_id = ?',
      whereArgs: [exerciseId],
      orderBy: 'set_order ASC',
    );

    return exerciseSetsByMovementId;
  }

  // Future<List<Map<String, dynamic>>> getMovementPRSetsWrapper(
  //     int movementId) async {
  //   final db = await databaseHelper.database;
  //
  //   List<Map<String, dynamic>> returnData = [];
  //
  //   List<Map<String, dynamic>> movementPRs =
  //       await getLastPRSessionsByMovementId(movementId, db);
  //
  //   if (movementPRs.isEmpty) return returnData;
  // }

  Future<List<Map<String, dynamic>>> queryDistinctPRSetsByMovementId(
      int movementId, dbConnection) async {
    String queryPRsForMovementIdWithDupes = """
       SELECT
        $exerciseSetTableName.weight,
        $exerciseSetTableName.reps,
        $exerciseSetTableName.extra_reps,
        $exerciseSetTableName.set_order,
        
        $workoutTableName.year,
        $workoutTableName.month,
        $workoutTableName.day,
 
        $workoutTableName.start_time,
        
        $exerciseTableName.movement_id,
        $exerciseTableName.workout_id,
        $exerciseTableName.id AS exercise_id,
        $exerciseSetTableName.id AS exercise_set_id,
        
        DENSE_RANK() OVER (
          PARTITION BY
            $exerciseSetTableName.weight,
            $exerciseSetTableName.reps,
            $exerciseSetTableName.extra_reps
          ORDER BY
            $workoutTableName.year ASC,
            $workoutTableName.month ASC,
            $workoutTableName.day ASC,
            $exerciseSetTableName.set_order ASC
          ) AS dense_rank  
      FROM $exerciseTableName
      JOIN $workoutTableName ON 
        $exerciseTableName.workout_id = $workoutTableName.id
      JOIN $exerciseSetTableName ON
        $exerciseSetTableName.exercise_id = $exerciseTableName.id
        
      WHERE 
        $exerciseTableName.movement_id = $movementId 
      ORDER BY
        $exerciseSetTableName.weight DESC, 
        $exerciseSetTableName.reps DESC, 
        $exerciseSetTableName.extra_reps DESC
      LIMIT 5
      """;

    String filteredQueryForUniquePRs = """
    WITH unfiltered AS ($queryPRsForMovementIdWithDupes)
    
    SELECT 
      unfiltered.weight,
      unfiltered.reps,
      unfiltered.extra_reps,
      unfiltered.set_order,
      
      unfiltered.year,
      unfiltered.month,
      unfiltered.day,
      unfiltered.start_time,
      
      unfiltered.movement_id,
      unfiltered.workout_id,
      unfiltered.exercise_id,
      unfiltered.exercise_set_id
    FROM unfiltered
    WHERE dense_rank = 1;
    """;
    List<Map<String, dynamic>> movementPRsList =
        await dbConnection.rawQuery(filteredQueryForUniquePRs);

    return movementPRsList;
  }

  Future<List<Map<String, dynamic>>> getDistinctPRSetsByMovementIdWrapper(
      int movementId) async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> PRSets =
        await queryDistinctPRSetsByMovementId(movementId, db);

    final List<Map<String, dynamic>> formattedPRSets = [];

    for (Map<String, dynamic> PRSet in PRSets) {
      List<Map<String, dynamic>> returnExerciseSet =
          await queryExerciseSetsByExerciseId(PRSet['exercise_set_id'], db);
      formattedPRSets.add({
        'data': returnExerciseSet,
        'year': PRSet['year'],
        'month': PRSet['month'],
        'day': PRSet['day']
      });
    }

    return formattedPRSets;
  }

  Future<Map> getMovementPRSet(int movementId) async {
    final db = await databaseHelper.database;

    final Map returnObj = await db.transaction((txn) async {
      String queryPRForMovementId = """
      SELECT $exerciseSetTableName.* FROM $exerciseSetTableName
      JOIN $exerciseTableName ON 
        $exerciseTableName.id = $exerciseSetTableName.exercise_id
      WHERE $exerciseTableName.movement_id = $movementId
      ORDER BY
        $exerciseSetTableName.weight DESC, 
        $exerciseSetTableName.reps DESC, 
        $exerciseSetTableName.extra_reps DESC
      LIMIT 1;
      """;
      List<Map> movementPRList = await txn.rawQuery(queryPRForMovementId);
      if (movementPRList.isEmpty) {
        List<Map> returnList = [];
        return {'data': returnList};
      }
      Map movementPR = movementPRList.first;

      String queryPRDate = """
      SELECT 
        $workoutTableName.year, 
        $workoutTableName.month, 
        $workoutTableName.day 
      FROM $workoutTableName
      JOIN $exerciseTableName ON 
        $workoutTableName.id = $exerciseTableName.workout_id
      WHERE 
        $exerciseTableName.id = ${movementPR['exercise_id']};      
      """;
      List<Map> movementPRDateList = await txn.rawQuery(queryPRDate);
      Map movementPRDate = movementPRDateList.first;

      return {
        'data': movementPR,
        'year': movementPRDate['year'],
        'month': movementPRDate['month'],
        'day': movementPRDate['day']
      };
    });

    return returnObj;
  }

  Future<List<ExerciseSetTable>> getAllExerciseSetsByExerciseId(
      int exerciseId) async {
    final db = await databaseHelper.database;

    String dbQuery = """
    SELECT
      $exerciseSetTableName.id,
      $exerciseSetTableName.exercise_id,
      $exerciseSetTableName.set_order,
      $exerciseSetTableName.is_warm_up,
      $exerciseSetTableName.weight,
      $exerciseSetTableName.reps,
      $exerciseSetTableName.extra_reps,
      $exerciseSetTableName.duration,
      $exerciseSetTableName.notes
    FROM $exerciseSetTableName
    WHERE $exerciseSetTableName.exercise_id = $exerciseId
    ORDER BY $exerciseSetTableName.set_order ASC;
    """;

    final List<Map<String, dynamic>> allExerciseSets =
        await db.rawQuery(dbQuery);

    return allExerciseSets
        .map((exerciseSet) => ExerciseSetTable.fromMap(exerciseSet))
        .toList();
  }
}
