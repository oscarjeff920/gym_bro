import 'dart:core';

import 'package:gym_bro/constants/utils/custom_datetime_utils.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_helper.dart';

import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';

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
        'sets': exerciseSetsData
            .map((exerciseSet) =>
                GeneralExerciseSetModel.fromDbMap(map: exerciseSet))
            .toList(),
        'year': exerciseData['year'],
        'month': exerciseData['month'],
        'day': exerciseData['day'],
        'dateString': CustomDatetimeUtils.dateToString(
            exerciseData['year'], exerciseData['month'], exerciseData['day'])
      });
    }

    return returnData;
  }

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

  Future<List<Map<String, dynamic>>> getDistinctPRSetsByMovementIdWrapper(
      int movementId) async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> PRSets =
        await queryDistinctPRSetsByMovementId(movementId, db);

    final List<Map<String, dynamic>> formattedPRSets = [];

    for (Map<String, dynamic> PRSetData in PRSets) {
      List<Map<String, dynamic>> returnExerciseSet =
          await queryExerciseSetsByExerciseSetId(
              PRSetData['exercise_set_id'], db);
      formattedPRSets.add({
        'PR_set': GeneralExerciseSetModel.fromDbMap(map: returnExerciseSet.first),
        'year': PRSetData['year'],
        'month': PRSetData['month'],
        'day': PRSetData['day'],
        'dateString': CustomDatetimeUtils.dateToString(
            PRSetData['year'], PRSetData['month'], PRSetData['day'])
      });
    }

    return formattedPRSets;
  }

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

  Future<List<Map<String, dynamic>>> queryExerciseSetsByExerciseSetId(
      int exerciseSetId, dbConnection) async {
    final List<Map<String, dynamic>> exerciseSetsByMovementId =
        await dbConnection.query(
      exerciseSetTableName,
      where: 'id = ?',
      whereArgs: [exerciseSetId],
      orderBy: 'set_order ASC',
    );

    return exerciseSetsByMovementId;
  }

  Future<List<ExerciseSetTable>> getAllExerciseSetsByExerciseId(
      int exerciseId) async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> allExerciseSets =
        await queryExerciseSetsByExerciseId(exerciseId, db);

    return allExerciseSets
        .map((exerciseSet) => ExerciseSetTable.fromMap(exerciseSet))
        .toList();
  }
}
