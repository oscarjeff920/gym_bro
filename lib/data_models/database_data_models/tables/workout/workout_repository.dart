import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/database/database_connector.dart';

class WorkoutRepository {
  final DatabaseHelper databaseHelper;

  WorkoutRepository(this.databaseHelper);

  // Methods to list workouts on home page:
  // Future<Map<DateTime, Map<int, List<LoadedWorkoutModel>>>>
  retrieveWorkoutsAndGroupByWeek(
      {required int limit, required int offset}) async {
    // getting all workouts in db by limit and offset
    List<WorkoutTable> allWorkouts =
        await getAllWorkouts(limit: limit, offset: offset);

    // getting all attached exercises by workout
    List<WorkoutTableWithExercisesWorkedMuscleGroups> allWorkoutsWithExercises =
        [];
    for (WorkoutTable workout in allWorkouts) {
      WorkoutTableWithExercisesWorkedMuscleGroups
          workoutTableWithExercisesWorkedMuscleGroups =
          await getExercisesByWorkoutId(workout);

      allWorkoutsWithExercises.add(workoutTableWithExercisesWorkedMuscleGroups);
    }

    Map<DateTime, Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>>
        workoutsGroupedByWeek = groupWorkoutsByWeek(allWorkoutsWithExercises);

    return workoutsGroupedByWeek;
  }

  Future<List<WorkoutTable>> getAllWorkouts(
      {required int limit, required int offset}) async {
    final db = await databaseHelper.database;

    final List<Map<String, dynamic>> workouts = await db.query(workoutTableName,
        orderBy: 'year DESC, month DESC, day DESC, start_time ASC',
        limit: limit,
        offset: offset);
    final List<WorkoutTable> convertedWorkouts =
        workouts.map((workout) => WorkoutTable.fromMap(workout)).toList();

    return convertedWorkouts;
  }

  // Future<WorkoutTableWithExercises>
  getExercisesByWorkoutId(WorkoutTable workout) async {
    final db = await databaseHelper.database;

    String getExercisesByWorkoutIdQueryString = '''
    SELECT 
      $exerciseTableName.*
    FROM 
      $exerciseTableName
    WHERE $exerciseTableName.workout_id = ${workout.id}
    ORDER BY $exerciseTableName.exercise_order;
    ''';

    final List<Map<String, dynamic>> mapExercises =
        await db.rawQuery(getExercisesByWorkoutIdQueryString);

    final List<ExerciseTableWithWorkedMuscleGroups> exercises = [];
    for (Map<String, dynamic> exercise in mapExercises) {
      // convert map into ExerciseTable obj
      ExerciseTable convertedExercise = ExerciseTable.fromMap(exercise);

      MovementWorkedMuscleGroupsType muscleGroupsWorked =
          await MovementWorkedMuscleGroupsType
              .getWorkedMuscleGroupsByMovementId(
                  convertedExercise.movementId, db);

      ExerciseTableWithWorkedMuscleGroups convertedExerciseWithMuscleGroups =
          ExerciseTableWithWorkedMuscleGroups(
              id: convertedExercise.id,
              movementId: convertedExercise.movementId,
              workoutId: convertedExercise.workoutId,
              exerciseOrder: convertedExercise.exerciseOrder,
              numWorkingSets: convertedExercise.numWorkingSets,
              workedMuscleGroups: muscleGroupsWorked);

      exercises.add(convertedExerciseWithMuscleGroups);
    }

    WorkoutTableWithExercisesWorkedMuscleGroups
        workoutTableWithExercisesWorkedMuscleGroups =
        WorkoutTableWithExercisesWorkedMuscleGroups(
            id: workout.id,
            year: workout.year,
            month: workout.month,
            day: workout.day,
            workoutStartTime: workout.workoutStartTime,
            duration: workout.duration,
            exercises: exercises);

    return workoutTableWithExercisesWorkedMuscleGroups;
  }

  Future<Map<MuscleGroupType, RoleType>> getWorkedMuscleGroupsByMovementId(
      int movementId, db) async {
    String queryString = '''
      SELECT 
        $movementMuscleGroupsTableName.role as role,
        $muscleGroupTableName.name as name
      FROM 
        $movementMuscleGroupsTableName
        
      JOIN $muscleGroupTableName
        ON $movementMuscleGroupsTableName.muscle_group_id = $muscleGroupTableName.id
        
      WHERE
        $movementMuscleGroupsTableName.movement_id = $movementId
    ''';

    List<Map> result = await db.rawQuery(queryString);

    Map<MuscleGroupType, RoleType> musclesWorked = {};
    for (var obj in result) {
      RoleType role = RoleType.values.byName(obj['role']);
      MuscleGroupType muscleGroup = MuscleGroupType.values.byName(obj['name']);

      musclesWorked[muscleGroup] = role;
    }

    return musclesWorked;
  }

  Map<DateTime, Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>>
      groupWorkoutsByWeek(
          List<WorkoutTableWithExercisesWorkedMuscleGroups> ungroupedWorkouts) {
    // Make sure the current week exists
    DateTime dateTimeNow = DateTime.now();
    // Because two or more workouts can occur on the same day, we need to save
    // the workouts within a list so the user can select from any
    // Map<DateTime, Map<int, List<LoadedWorkoutModel>>>
    Map<DateTime, Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>>
        workoutsGroupedByWeek = {
      getWeekBeginningDate(
          DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day),
          dateTimeNow.weekday): {}
    };

    for (var workout in ungroupedWorkouts) {
      DateTime date = DateTime(workout.year, workout.month, workout.day);
      int weekdayInteger = date.weekday;

      DateTime weekBeginningDate = getWeekBeginningDate(date, weekdayInteger);

      // weekday integers start at 1 so to match indices we need to -1
      if (workoutsGroupedByWeek.containsKey(weekBeginningDate)) {
        if (workoutsGroupedByWeek[weekBeginningDate]!
            .containsKey(weekdayInteger - 1)) {
          workoutsGroupedByWeek[weekBeginningDate]![weekdayInteger - 1]!
              .add(workout);
        } else {
          workoutsGroupedByWeek[weekBeginningDate]![weekdayInteger - 1] = [
            workout
          ];
        }
      } else {
        workoutsGroupedByWeek[weekBeginningDate] = {
          weekdayInteger - 1: [workout]
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

  // ================================================================================

  // Insert New Movement method
  insertNewMovement(
      GeneralWorkoutPageExerciseModel newMovementExercise, txn) async {
    String lowerCaseMovementName =
        newMovementExercise.movementName.toLowerCase();

    // first we check to see if the movement does exist in the db
    String queryString = '''
    SELECT id FROM $movementTableName
    WHERE name = "$lowerCaseMovementName";
    ''';
    final List<Map<String, dynamic>> existingMovementId =
        await txn.rawQuery(queryString);
    if (existingMovementId.isNotEmpty) return existingMovementId.first['id'];

    // if the movement doesn't exist we need to insert it
    String insertNewMovementString = '''
    INSERT INTO $movementTableName (name) VALUES
      ("$lowerCaseMovementName");
    ''';
    final newMovementId = await txn.rawInsert(insertNewMovementString);

    // As each movement can utilise a number of muscle groups
    // the id for each muscle group within workedMuscleGroups must be fetched
    for (var entry in newMovementExercise
        .workedMuscleGroups.workedMuscleGroupsMap.entries) {
      String queryMuscleGroupsString = '''
        SELECT id FROM $muscleGroupTableName
        WHERE name = "${entry.key.name}";
      ''';

      final List<Map<String, dynamic>> primaryMuscleGroupId =
          await txn.rawQuery(queryMuscleGroupsString);

      // next we insert the association data
      String insertNewMovementMuscleGroupsString = '''
        INSERT INTO $movementMuscleGroupsTableName VALUES
        ($newMovementId, ${primaryMuscleGroupId.first["id"]}, "${entry.value.name}");
      ''';

      await txn.rawInsert(insertNewMovementMuscleGroupsString);
    }

    return newMovementId;
  }

  insertNewFullWorkout(NewWorkoutModel newWorkout) async {
    final db = await databaseHelper.database;

    await db.transaction((txn) async {
      String? startTime = newWorkout.workoutStartTime == null
          ? null
          : '${newWorkout.workoutStartTime}';

      String? workoutDuration = newWorkout.workoutDuration == null
          ? null
          : '${newWorkout.workoutDuration}';

      // Inserting the Workout into the database
      String insertWorkoutQueryString = '''
      INSERT INTO $workoutTableName (day, month, year, start_time, duration) VALUES
          (${newWorkout.day}, ${newWorkout.month}, ${newWorkout.year}, $startTime, $workoutDuration);
      ''';
      final newWorkoutId = await txn.rawInsert(insertWorkoutQueryString);

      // Getting Movement Id to enter into the exercise row
      int exerciseOrder = 0;
      for (var exercise in newWorkout.exercises) {
        final int movementId;
        if (exercise.movementId == null) {
          // if movementId is null the movement is new
          // it needs to be added to the DB to get the id.
          movementId = await insertNewMovement(exercise, txn);
        } else {
          movementId = exercise.movementId!;
        }

        // Inserting Exercise into the database
        String insertExerciseString = '''
        INSERT INTO $exerciseTableName
            (movement_id, workout_id, exercise_order, duration, num_working_sets) VALUES
            ($movementId, $newWorkoutId, $exerciseOrder, '"${exercise.exerciseDuration}"', ${exercise.numWorkingSets});
        ''';
        final newExerciseId = await txn.rawInsert(insertExerciseString);
        exerciseOrder += 1;

        for (var exerciseSet in exercise.exerciseSets) {
          String insertExerciseSetString = '''
          INSERT INTO $exerciseSetTableName
          (exercise_id, set_order, is_warm_up, weight, reps, extra_reps, duration, notes) VALUES
          ($newExerciseId, ${exerciseSet.exerciseSetOrder}, ${exerciseSet.isWarmUp}, ${exerciseSet.weight},
           ${exerciseSet.reps}, ${exerciseSet.extraReps}, '"${exerciseSet.setDuration}"', "${exerciseSet.notes}");
          ''';
          await txn.rawInsert(insertExerciseSetString);
        }
      }
    });
  }
}
