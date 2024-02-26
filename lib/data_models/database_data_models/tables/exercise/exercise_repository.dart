import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

import 'exercise_table_object.dart';

class ExerciseRepository {
  final DatabaseHelper databaseHelper;

  ExerciseRepository(this.databaseHelper);

  Future<List<ExerciseTable>> getAllExercisesByWorkoutId (int workoutId) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allExercises = await db.rawQuery("""
    SELECT * FROM $exerciseTableName
    JOIN $movementTableName ON $exerciseTableName.movement_id = $movementTableName.id
    WHERE $exerciseTableName.workout_id = $workoutId
    ORDER BY $exerciseTableName.exercise_order ASC;
    """);

    return allExercises.map((exercise) => ExerciseTable.fromMap(exercise)).toList();
  }
}