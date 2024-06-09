import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';
import 'package:sqflite/sqflite.dart';

class MovementRepository {
  final DatabaseHelper databaseHelper;

  MovementRepository(this.databaseHelper);

  Future<void> inspectSchema() async {
    Database db = await databaseHelper.database;

    print("\n\n========= INSPECTING SCHEMA ==========");
    List<Map<String, dynamic>> tables = await db.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', 'workout'],
    );
    for (Map<String, dynamic> table in tables) {
      String tableName = table['name'];
      print('Table: $tableName');

      List<Map<String, dynamic>> columns = await db.query(tableName);
      for (Map<String, dynamic> column in columns) {
        print('Column: ${column['name']}');
      }
    }
  }

  Future<List<Map>> getLatestMovementExercise(int movementId) async {
    final db = await databaseHelper.database;

    // Sub-query to find the most recent exercise with movement_id = 1
    String queryMostRecentExerciseByMovementIdString = """
    WITH most_recent_exercise AS (
        SELECT exercise.id
        FROM exercise
        JOIN workout ON exercise.workout_id = workout.id
        WHERE exercise.movement_id = 2
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

    List<Map> latestExerciseSetsByMovementId = await db.rawQuery(combinedQueryString);

    return latestExerciseSetsByMovementId;
  }

  Future<List<MovementMuscleGroupJoin>> getAllMovementsByMuscleGroup(
      MuscleGroupType selectedMuscleGroup) async {
    final db = await databaseHelper.database;

    String dbQuery = """
        SELECT
          $movementTableName.name AS movement_name,
          $muscleGroupTableName.name AS muscle_group_name,
          *
        FROM $movementTableName

        JOIN $movementMuscleGroupsTableName
          ON $movementTableName.id = $movementMuscleGroupsTableName.movement_id
        JOIN $muscleGroupTableName
          ON $movementMuscleGroupsTableName.muscle_group_id = $muscleGroupTableName.id

        WHERE
          muscle_group_name = '${selectedMuscleGroup.name}'
          AND
          role = 'primary'
          
        ORDER BY
          movement_name ASC
        ;
        """;

    final List<Map<String, dynamic>> movements = await db.rawQuery(dbQuery);
    return movements
        .map((movement) => MovementMuscleGroupJoin.fromMap(movement))
        .toList();
  }
}
