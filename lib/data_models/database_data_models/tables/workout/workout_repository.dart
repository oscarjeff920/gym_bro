import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/database/database_connector.dart';

class WorkoutRepository {
  final DatabaseHelper databaseHelper;

  WorkoutRepository(this.databaseHelper);

  Future<List<WorkoutTable>> getAllWorkouts() async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> workouts = await db.query(workoutTableName,
        orderBy: 'year DESC, month DESC, day DESC');
    return workouts.map((workout) => WorkoutTable.fromMap(workout)).toList();
  }

  insertNewFullWorkout(NewWorkoutModel newWorkout) async {
    final db = await databaseHelper.database;

    await db.transaction((txn) async {
      String insertWorkoutQueryString = """
      INSERT INTO $workoutTableName (day, month, year, duration) VALUES
          (${newWorkout.day}, ${newWorkout.month}, ${newWorkout.year}, '${newWorkout.workoutDuration}');
      """;
      final newWorkoutId = await txn.rawInsert(insertWorkoutQueryString);

      int exerciseOrder = 1;
      for (var exercise in newWorkout.exercises) {
        String insertExerciseString = """
        INSERT INTO $exerciseTableName 
            (movement_id, workout_id, exercise_order, duration, num_working_sets) VALUES
            (${exercise.movementId}, $newWorkoutId, $exerciseOrder, '${exercise.exerciseDuration}', ${exercise.numWorkingSets}); 
        """;
        final newExerciseId = await txn.rawInsert(insertExerciseString);
        exerciseOrder += 1;

        int exerciseSetOrder = 1;
        for (var exerciseSet in exercise.exerciseSets) {
          String insertExerciseSetString = """
          INSERT INTO $exerciseSetTableName 
          (exercise_id, set_order, is_warm_up, weight, reps, extra_reps, duration, notes) VALUES
          ($newExerciseId, $exerciseSetOrder, ${exerciseSet.isWarmUp}, ${exerciseSet.weight}, 
           ${exerciseSet.reps}, ${exerciseSet.extraReps}, '${exerciseSet.repDuration}', '${exerciseSet.notes}');
          """;
          await txn.rawInsert(insertExerciseSetString);
          exerciseSetOrder += 1;
        }
      }
    });
  }
}
