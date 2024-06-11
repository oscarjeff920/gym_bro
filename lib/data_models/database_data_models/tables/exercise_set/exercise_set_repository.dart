import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

import 'exercise_set_object.dart';

class ExerciseSetRepository {
  final DatabaseHelper databaseHelper;

  ExerciseSetRepository(this.databaseHelper);

  Future<List<Map>> getLatestExerciseSetsByMovement(int movementId) async {
    final db = await databaseHelper.database;

    // Sub-query to find the most recent exercise with movement_id
    String queryMostRecentExerciseByMovementIdString = """
    WITH most_recent_exercise AS (
        SELECT exercise.id
        FROM exercise
        JOIN workout ON exercise.workout_id = workout.id
        WHERE exercise.movement_id = $movementId
        ORDER BY workout.year DESC, workout.month DESC, workout.day DESC
        LIMIT 1
    )\n
    """;

    // Main query to get all exercise_set records for the most recent exercise
    String queryAllExerciseSetsByExerciseIdString = """
    SELECT exercise_set.*
    FROM exercise_set
    JOIN most_recent_exercise ON exercise_set.exercise_id = most_recent_exercise.id
    ORDER BY exercise_set.set_order ASC;
    """;

    // Full Query
    String combinedQueryString = queryMostRecentExerciseByMovementIdString +
        queryAllExerciseSetsByExerciseIdString;

    List<Map> latestExerciseSetsByMovementId =
        await db.rawQuery(combinedQueryString);

    return latestExerciseSetsByMovementId;
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
