import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class ActiveWorkoutCubit extends Cubit<ActiveWorkoutState> {
  ActiveWorkoutCubit() : super(ActiveWorkoutState());

  resetState() {
    emit(ActiveWorkoutState());
  }

  String convertSingleDigitDateTimeToDoubleDigit(int timeDate) {
    if (timeDate < 10 && timeDate > 0) {
      return "0$timeDate";
    }
    return timeDate.toString();
  }

  createNewWorkoutState() {
    DateTime dateToday = DateTime.now();

    emit(NewActiveWorkoutState(
        day: dateToday.day,
        month: dateToday.month,
        year: dateToday.year,
        workoutStartTime:
            "${convertSingleDigitDateTimeToDoubleDigit(dateToday.hour)}:"
            "${convertSingleDigitDateTimeToDoubleDigit(dateToday.minute)}:"
            "${convertSingleDigitDateTimeToDoubleDigit(dateToday.second)}",
        exercises: const []));
  }

  updateNewWorkoutDuration(String? workoutDuration) {
    if (state is NewActiveWorkoutState && workoutDuration != null) {
      NewActiveWorkoutState currentState = state as NewActiveWorkoutState;

      NewActiveWorkoutState workoutStateWithDuration = NewActiveWorkoutState(
          day: currentState.day,
          month: currentState.month,
          year: currentState.year,
          workoutStartTime: currentState.workoutStartTime,
          workoutDuration: workoutDuration,
          exercises: currentState.exercises);

      emit(workoutStateWithDuration);
    }
  }

  saveFinishedExerciseToWorkoutState(AddExerciseState newExercise) {
    if (state is NewActiveWorkoutState) {
      NewActiveWorkoutState currentState = state as NewActiveWorkoutState;

      int index = 0;

      NewExerciseModel updatedExercise = NewExerciseModel(
          movementId: newExercise.selectedMovementId,
          exerciseOrder: currentState.exercises.length,
          exerciseDuration: null,
          // TODO: add exercise duration
          numWorkingSets: newExercise.numWorkingSets,
          workedMuscleGroups: newExercise.workedMuscleGroups!,
          movementName: newExercise.selectedMovement!,
          exerciseSets: newExercise.setsDone.map((set_) {
            GeneralExerciseSetModel convertedModel =
                GeneralExerciseSetModel.fromSetsObject(
                    exerciseSet: set_, setOrder: index);
            index += 1;

            return convertedModel;
          }).toList());

      NewActiveWorkoutState generatedState = NewActiveWorkoutState.copyWith(
          currentState: currentState, newExercises: [updatedExercise]);

      emit(generatedState);
    } else {
      StateError("Cannot update state: $state != NewActiveWorkoutState");
    }
  }

  finishWorkout(String workoutDuration) {
    // this saves the final workout duration to the state.
    if (state is NewActiveWorkoutState &&
        (state as NewActiveWorkoutState).exercises.isNotEmpty) {
      NewActiveWorkoutState currentState = state as NewActiveWorkoutState;

      NewActiveWorkoutState generatedState = NewActiveWorkoutState.copyWith(
          currentState: currentState, workoutDuration: workoutDuration);

      emit(generatedState);
    } else {
      StateError("Cannot update state: $state != NewActiveWorkoutState");
    }
  }

  loadSavedJsonWorkoutToState(Map<String, dynamic> savedJsonWorkoutState) {
    NewActiveWorkoutState loadedState = NewActiveWorkoutState(
        day: savedJsonWorkoutState['day'],
        month: savedJsonWorkoutState['month'],
        year: savedJsonWorkoutState['year'],
        workoutStartTime: savedJsonWorkoutState['workoutStartTime'],
        workoutDuration: savedJsonWorkoutState['workoutDuration'],
        exercises: savedJsonWorkoutState['exercises']
            .map<NewExerciseModel>((exerciseMap) {
          return NewExerciseModel.fromMap(map: exerciseMap);
        }).toList()
    );

    emit(loadedState);
  }

  // ================================================================================

  loadHomePageWorkoutToState(
      WorkoutTableWithExercisesWorkedMuscleGroups loadedWorkout) {
    // When a workout has been selected from the home page, an intermediate state is emitted
    // LoadingActiveWorkoutState

    // This is because both the movement name and exercise sets need to be fetched
    // via loadExerciseNamesToState and loadExerciseSetsToState

    LoadingActiveWorkoutState loadingWorkoutState = LoadingActiveWorkoutState(
        id: loadedWorkout.id,
        day: loadedWorkout.day,
        month: loadedWorkout.month,
        year: loadedWorkout.year,
        workoutStartTime: loadedWorkout.workoutStartTime,
        workoutDuration: loadedWorkout.duration,
        exercises: loadedWorkout.exercises.map((exercise) {
          SelectedWorkoutIntermittentExerciseModel generatedExercise =
              SelectedWorkoutIntermittentExerciseModel
                  .fromExerciseTableWithWorkedMuscleGroups(exercise);
          return generatedExercise;
        }).toList());

    emit(loadingWorkoutState);
  }

  // TODO: refactor
  loadExerciseNamesToState(Map<int, String> exerciseMovementNameIndex) {
    if (state is LoadingActiveWorkoutState) {
      LoadingActiveWorkoutState currentState =
          state as LoadingActiveWorkoutState;

      // if we've already fetched and loaded in the exercise sets
      // the LoadedActiveWorkoutState can be emitted
      if (currentState.exercises[0].exerciseSets.isNotEmpty) {
        // LoadedActiveWorkoutState uses GeneralWorkoutPageExerciseModel
        List<GeneralWorkoutPageExerciseModel> exercisesWithNames = [];

        for (SelectedWorkoutIntermittentExerciseModel exercise
            in currentState.exercises) {
          SelectedWorkoutIntermittentExerciseModel updatedExercise =
              SelectedWorkoutIntermittentExerciseModel.copyWith(
                  currentModel: exercise,
                  movementName: exerciseMovementNameIndex[exercise.movementId]);

          exercisesWithNames.add(GeneralWorkoutPageExerciseModel
              .fromSelectedWorkoutIntermittentExerciseModel(updatedExercise));
        }

        LoadedActiveWorkoutState stateToEmit = LoadedActiveWorkoutState(
            id: currentState.id,
            day: currentState.day,
            month: currentState.month,
            year: currentState.year,
            workoutStartTime: currentState.workoutStartTime,
            workoutDuration: currentState.workoutDuration,
            exercises: exercisesWithNames);

        emit(stateToEmit);
      }

      // if the exercise sets haven't been loaded yet, we emit
      // LoadingActiveWorkoutState
      else {
        List<SelectedWorkoutIntermittentExerciseModel> exercisesWithNames = [];

        for (SelectedWorkoutIntermittentExerciseModel exercise
            in currentState.exercises) {
          SelectedWorkoutIntermittentExerciseModel updatedExercise =
              SelectedWorkoutIntermittentExerciseModel.copyWith(
                  currentModel: exercise,
                  movementName: exerciseMovementNameIndex[exercise.movementId]);

          exercisesWithNames.add(updatedExercise);
        }

        LoadingActiveWorkoutState stateToEmit = LoadingActiveWorkoutState(
            id: currentState.id,
            day: currentState.day,
            month: currentState.month,
            year: currentState.year,
            workoutStartTime: currentState.workoutStartTime,
            workoutDuration: currentState.workoutDuration,
            exercises: exercisesWithNames);

        emit(stateToEmit);
      }
    } else {
      StateError("Cannot load exercise names to state: $state");
    }
  }

  // TODO: refactor
  loadExerciseSetsToState(
      Map<int, List<ExerciseSetTable>> exerciseSetExerciseIndex) {
    if (state is LoadingActiveWorkoutState) {
      LoadingActiveWorkoutState currentState =
          state as LoadingActiveWorkoutState;

      // if we've already fetched and loaded in the movement names
      // the LoadedActiveWorkoutState can be emitted
      if (currentState.exercises[0].movementName != '') {
        List<GeneralWorkoutPageExerciseModel> exercisesWithExerciseSets = [];

        for (SelectedWorkoutIntermittentExerciseModel exercise
            in currentState.exercises) {
          // we update the current exercise with the fetched exerciseSets
          SelectedWorkoutIntermittentExerciseModel updatedExercise =
              SelectedWorkoutIntermittentExerciseModel.copyWith(
                  currentModel: exercise,
                  exerciseSets: exerciseSetExerciseIndex[exercise.id]!
                      .map((set_) =>
                          GeneralExerciseSetModel.fromExerciseSetTable(set_))
                      .toList());

          exercisesWithExerciseSets.add(GeneralWorkoutPageExerciseModel
              .fromSelectedWorkoutIntermittentExerciseModel(updatedExercise));
        }

        LoadedActiveWorkoutState stateToEmit = LoadedActiveWorkoutState(
            id: currentState.id,
            day: currentState.day,
            month: currentState.month,
            year: currentState.year,
            workoutStartTime: currentState.workoutStartTime,
            workoutDuration: currentState.workoutDuration,
            exercises: exercisesWithExerciseSets);

        emit(stateToEmit);
      }

      // if the movement names haven't been loaded yet, we emit LoadingActiveWorkoutState
      else {
        List<SelectedWorkoutIntermittentExerciseModel>
            exercisesWithExerciseSets = [];

        for (SelectedWorkoutIntermittentExerciseModel exercise
            in currentState.exercises) {
          // we update the current exercise with the fetched exerciseSets
          SelectedWorkoutIntermittentExerciseModel updatedExercise =
              SelectedWorkoutIntermittentExerciseModel.copyWith(
                  currentModel: exercise,
                  exerciseSets: exerciseSetExerciseIndex[exercise.id]!
                      .map((set_) =>
                          GeneralExerciseSetModel.fromExerciseSetTable(set_))
                      .toList());

          exercisesWithExerciseSets.add(updatedExercise);
        }

        LoadingActiveWorkoutState stateToEmit = LoadingActiveWorkoutState(
            id: currentState.id,
            day: currentState.day,
            month: currentState.month,
            year: currentState.year,
            workoutStartTime: currentState.workoutStartTime,
            workoutDuration: currentState.workoutDuration,
            exercises: exercisesWithExerciseSets);

        emit(stateToEmit);
      }
    } else {
      StateError("Cannot load exercise sets to state: $state");
    }
  }
}
