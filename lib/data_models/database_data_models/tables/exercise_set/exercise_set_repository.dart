import 'dart:core';

import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

import 'exercise_set_object.dart';

class ExerciseSetRepository {
  final DatabaseHelper databaseHelper;

  ExerciseSetRepository(this.databaseHelper);

  // to display the sets from the most recent exercise of this movement
  Future<Map> getLatestExerciseSetsByMovement(int movementId) async {
    final db = await databaseHelper.database;

    final returnObj = await db.transaction((txn) async {
      // Sub-query to find the most recent exercise with movement_id
      String queryMostRecentExerciseByMovementIdString = """
      SELECT 
        $exerciseTableName.id,
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
      LIMIT 1;
      """;
      List<Map<String, dynamic>> latestExercise =
          await txn.rawQuery(queryMostRecentExerciseByMovementIdString);
      if (latestExercise.isEmpty) {
        List<Map<String, dynamic>> returnList = [];
        return {'data': returnList};
      }

      // Main query to get all exercise_set records for the most recent exercise
      String queryAllExerciseSetsByExerciseIdString = """
      SELECT $exerciseSetTableName.* FROM $exerciseSetTableName
      JOIN $exerciseTableName ON 
        $exerciseSetTableName.exercise_id = $exerciseTableName.id
      WHERE
        $exerciseTableName.id = ${latestExercise.first['id']}
      ORDER BY $exerciseSetTableName.set_order ASC;
      """;

      List<Map<String, dynamic>> latestExerciseSetsByMovementId =
          await txn.rawQuery(queryAllExerciseSetsByExerciseIdString);

      return {
        'data': latestExerciseSetsByMovementId,
        'year': latestExercise.first['year'],
        'month': latestExercise.first['month'],
        'day': latestExercise.first['day']
      };
    });

    return returnObj;
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
