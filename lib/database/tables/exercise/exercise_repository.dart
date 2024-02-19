import 'package:gym_bro/database/database_connector.dart';
import 'package:gym_bro/database/tables/exercise/exercise_constants.dart';

import 'exercise_table_object.dart';

class ExerciseRepository {
  final DatabaseHelper databaseHelper;

  ExerciseRepository(this.databaseHelper);

  Future<List<Exercise>> getAllExercises () async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allExercises = await db.query(tableName);

    return allExercises.map((exercise) => Exercise.fromMap(exercise)).toList();
  }
}