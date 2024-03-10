import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';


class ExerciseRepository {
  final DatabaseHelper databaseHelper;

  ExerciseRepository(this.databaseHelper);

  Future<List<LoadedExerciseModel>> getAllExercisesByWorkoutId(int workoutId) async {
    final db = await databaseHelper.database;
    print('workoutId: $workoutId');
    final List<Map<String, dynamic>> allExercises = await db.rawQuery("""
    SELECT
      $exerciseTableName.id AS id,
      $exerciseTableName.exercise_order AS exercise_order,
      $movementTableName.name AS movement_name,
      $exerciseTableName.movement_id AS movement_id,
      $exerciseTableName.duration AS exercise_duration,
      $exerciseTableName.num_working_sets AS num_working_sets,
      $muscleGroupTableName.name as primary_muscle_group_name
    FROM $exerciseTableName
    JOIN $movementTableName ON $exerciseTableName.movement_id = $movementTableName.id
    JOIN $movementMuscleGroupsTableName ON $movementTableName.id = $movementMuscleGroupsTableName.movement_id
    JOIN $muscleGroupTableName ON $movementMuscleGroupsTableName.muscle_group_id = $muscleGroupTableName.id
    WHERE $exerciseTableName.workout_id = $workoutId AND $movementMuscleGroupsTableName.role = 'primary'
    ORDER BY $exerciseTableName.exercise_order ASC;
    """);

    return allExercises
        .map((exercise) => LoadedExerciseModel.fromMap(exercise))
        .toList();
  }

    Future<List<MuscleGroupType>> getSecondaryMuscleGroups(int movementId) async {
      final db = await databaseHelper.database;
      final List<Map<String, dynamic>> secondaryMuscleGroups = await db.rawQuery("""
      SELECT $muscleGroupTableName.name as muscle_name FROM $muscleGroupTableName
      JOIN $movementMuscleGroupsTableName ON $muscleGroupTableName.id = $movementMuscleGroupsTableName.muscle_group_id
      JOIN $movementTableName ON $movementMuscleGroupsTableName.movement_id = $movementTableName.id
      WHERE $movementTableName.id = $movementId AND $movementMuscleGroupsTableName.role = 'secondary';
      """);

      return secondaryMuscleGroups.map((muscleGroup) => MuscleGroupType.values.byName(muscleGroup['muscle_name'])).toList();
    }
}
