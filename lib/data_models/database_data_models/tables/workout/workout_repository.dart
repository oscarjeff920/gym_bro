import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/database/database_connector.dart';

class WorkoutRepository {
  final DatabaseHelper databaseHelper;

  WorkoutRepository(this.databaseHelper);

  // Methods to list workouts on home page:

  Future<List<WorkoutTable>> getAllWorkouts(
      {required int limit, required int offset}) async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> workouts = await db.query(workoutTableName,
        orderBy: 'year DESC, month DESC, day DESC, start_time DESC',
        limit: limit,
        offset: offset);
    final List<WorkoutTable> convertedWorkouts =
        workouts.map((workout) => WorkoutTable.fromMap(workout)).toList();

    return convertedWorkouts;
  }

  Future<Map<DateTime, Map<int, LoadedWorkoutModel>>>
      retrieveWorkoutsAndGroupByWeek(
          {required int limit, required int offset}) async {
    List<WorkoutTable> retrievedWorkouts =
        await getAllWorkouts(limit: limit, offset: offset);

    Map<DateTime, Map<int, LoadedWorkoutModel>> workoutsGroupedByWeek =
        groupWorkoutsByWeek(retrievedWorkouts);

    return workoutsGroupedByWeek;
  }

  Map<DateTime, Map<int, LoadedWorkoutModel>> groupWorkoutsByWeek(
      List<WorkoutTable> ungroupedWorkouts) {
    // Make sure the current week exists
    DateTime dateTimeNow = DateTime.now();
    Map<DateTime, Map<int, LoadedWorkoutModel>> workoutsGroupedByWeek = {
      getWeekBeginningDate(
          DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day),
          dateTimeNow.weekday): {}
    };

    for (var workout in ungroupedWorkouts) {
      DateTime date = DateTime(workout.year, workout.month, workout.day);
      int weekdayInteger = date.weekday;

      DateTime weekBeginningDate = getWeekBeginningDate(date, weekdayInteger);

      if (workoutsGroupedByWeek.containsKey(weekBeginningDate)) {
        workoutsGroupedByWeek[weekBeginningDate]![weekdayInteger] =
            LoadedWorkoutModel.fromTableModel(workout);
      } else {
        workoutsGroupedByWeek[weekBeginningDate] = {
          weekdayInteger: LoadedWorkoutModel.fromTableModel(workout)
        };
      }
    }

    return workoutsGroupedByWeek;
  }

  getWeekBeginningDate(DateTime date, int weekdayInteger) {
    int daysFromMonday = (weekdayInteger - 1);

    DateTime weekBeginningDate = date.subtract(Duration(days: daysFromMonday));

    return weekBeginningDate;
  }

  // Insert New Movement method

  insertNewMovement(NewExerciseModel newMovementExercise, txn) async {
    String lowerCaseMovementName =
        newMovementExercise.movementName.toLowerCase();
    // first we check to see if the movement does exist in the db
    String queryString = """
    SELECT id FROM $movementTableName
    WHERE name = '$lowerCaseMovementName';
    """;
    final List<Map<String, dynamic>> existingMovementId =
        await txn.rawQuery(queryString);
    if (existingMovementId.isNotEmpty) return existingMovementId.first['id'];

    // if the movement doesn't exist we need to insert it
    String insertNewMovementString = """
    INSERT INTO $movementTableName (name) VALUES
      ('$lowerCaseMovementName');
    """;
    final newMovementId = await txn.rawInsert(insertNewMovementString);

    // to make the association between movement and muscle group
    // we need to get the id of the muscle group in the db
    String queryMuscleGroupsString = """
    SELECT id FROM $muscleGroupTableName
    WHERE name = '${newMovementExercise.primaryMuscleGroup.toString().split(".").last}';
    """;
    final List<Map<String, dynamic>> primaryMuscleGroupId =
        await txn.rawQuery(queryMuscleGroupsString);

    // next we insert the association data
    String insertNewMovementMuscleGroupsString = """
    INSERT INTO $movementMuscleGroupsTableName VALUES
      ($newMovementId, ${primaryMuscleGroupId.first['id']}, 'primary');
    """;

    await txn.rawInsert(insertNewMovementMuscleGroupsString);

    return newMovementId;
  }

  insertNewFullWorkout(NewWorkoutModel newWorkout) async {
    final db = await databaseHelper.database;

    await db.transaction((txn) async {
      String? startTime = newWorkout.workoutStartTime == null
          ? null
          : "'${newWorkout.workoutStartTime}'";
      String? workoutDuration = newWorkout.workoutDuration == null
          ? null
          : "'${newWorkout.workoutDuration}'";

      String insertWorkoutQueryString = """
      INSERT INTO $workoutTableName (day, month, year, start_time, duration) VALUES
          (${newWorkout.day}, ${newWorkout.month}, ${newWorkout.year}, $startTime, $workoutDuration);
      """;
      final newWorkoutId = await txn.rawInsert(insertWorkoutQueryString);

      int exerciseOrder = 1;
      for (var exercise in newWorkout.exercises) {
        final int movementId;
        if (exercise.movementId == null) {
          // if the movement is new, it needs to be added to the DB to get the id
          movementId = await insertNewMovement(exercise, txn);
        } else {
          movementId = exercise.movementId!;
        }

        String insertExerciseString = """
        INSERT INTO $exerciseTableName 
            (movement_id, workout_id, exercise_order, duration, num_working_sets) VALUES
            ($movementId, $newWorkoutId, $exerciseOrder, '${exercise.exerciseDuration}', ${exercise.numWorkingSets}); 
        """;
        final newExerciseId = await txn.rawInsert(insertExerciseString);
        exerciseOrder += 1;

        int exerciseSetOrder = 1;
        for (var exerciseSet in exercise.exerciseSets) {
          String insertExerciseSetString = """
          INSERT INTO $exerciseSetTableName 
          (exercise_id, set_order, is_warm_up, weight, reps, extra_reps, duration, notes) VALUES
          ($newExerciseId, $exerciseSetOrder, ${exerciseSet.isWarmUp}, ${exerciseSet.weight}, 
           ${exerciseSet.reps}, ${exerciseSet.extraReps}, '${exerciseSet.setDuration}', '${exerciseSet.notes}');
          """;
          await txn.rawInsert(insertExerciseSetString);
          exerciseSetOrder += 1;
        }
      }
    });
  }
}
