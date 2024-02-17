import 'package:gym_bro/database/database_connector.dart';

class ExerciseRepository {
  final DatabaseHelper databaseHelper;

  ExerciseRepository(this.databaseHelper);

  Future<void> getAllExercises () async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allExercises = await db.query('exercise')
  }
}