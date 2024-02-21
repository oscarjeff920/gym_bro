import 'package:gym_bro/database/data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

import 'exercise_table_object.dart';

class ExerciseRepository {
  final DatabaseHelper databaseHelper;

  ExerciseRepository(this.databaseHelper);

  Future<List<Exercise>> getAllExercises () async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allExercises = await db.query(exerciseTableName);

    return allExercises.map((exercise) => Exercise.fromMap(exercise)).toList();
  }
}