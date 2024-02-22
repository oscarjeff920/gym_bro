import 'package:gym_bro/database/data_models/tables/table_constants.dart';
import 'package:gym_bro/database/data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/database/database_connector.dart';

class WorkoutRepository {
  final DatabaseHelper databaseHelper;

  WorkoutRepository(this.databaseHelper);

  Future<List<Workout>> getAllWorkouts() async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> workouts = await db.query(workoutTableName);
    return workouts.map((workout) => Workout.fromMap(workout)).toList();
  }
}