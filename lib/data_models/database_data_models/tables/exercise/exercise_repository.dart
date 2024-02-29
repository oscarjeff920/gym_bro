import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

import 'exercise_table_object.dart';

class ExerciseRepository {
  final DatabaseHelper databaseHelper;

  ExerciseRepository(this.databaseHelper);

  Future<List<ExerciseModel_WorkoutPage>> getAllExercisesByWorkoutId(int workoutId) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allExercises = await db.rawQuery("""
    SELECT
      $exerciseTableName.id,
      $exerciseTableName.exercise_order,
      $movementTableName.name,
      $exerciseTableName.movement_id,
      $exerciseTableName.duration,
      $exerciseTableName.num_working_sets,
      $muscleGroupTableName.name as primary_muscle_group_name
    FROM $exerciseTableName
    JOIN $movementTableName ON $exerciseTableName.movement_id = $movementTableName.id
    JOIN $movementMuscleGroupsTableName ON $movementTableName.id = $movementMuscleGroupsTableName.movement_id
    JOIN $muscleGroupTableName ON $movementMuscleGroupsTableName.muscle_group_id = $muscleGroupTableName.id
    WHERE $exerciseTableName.workout_id = $workoutId AND $movementMuscleGroupsTableName.role = 'primary'
    ORDER BY $exerciseTableName.exercise_order ASC;
    """);

    return allExercises
        .map((exercise) => ExerciseModel_WorkoutPage.fromMap(exercise))
        .toList();
  }
}
