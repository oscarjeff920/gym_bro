import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
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

  addNewExerciseToWorkoutState(AddExerciseState newExercise) {
    if (state is NewActiveWorkoutState) {
      NewActiveWorkoutState currentState = state as NewActiveWorkoutState;

      NewExerciseModel updatedExercise = NewExerciseModel(
          exerciseOrder: currentState.exercises.length + 1,
          movementName: newExercise.selectedMovement!,
          movementId: newExercise.selectedMovementId,
          primaryMuscleGroup: newExercise.selectedMuscleGroup!,
          numWorkingSets: newExercise.numWorkingSets,
          exerciseSets: newExercise.setsDone
              .map((set_) => NewExerciseSetModel(
                  exerciseSetOrder: 0,
                  isWarmUp: set_.isWarmUp,
                  weight: set_.weight.toDouble(),
                  reps: set_.reps,
                  extraReps: set_.extraReps,
                  setDuration: set_.setDuration.toString(),
                  notes: set_.notes))
              .toList());

      NewActiveWorkoutState generatedState =
          currentState.copyWith(newExercises: [updatedExercise]);

      emit(generatedState);
    } else {
      StateError("Cannot update state: $state != NewActiveWorkoutState");
    }
  }

  finishWorkout(String workoutDuration) {
    if (state is NewActiveWorkoutState &&
        (state as NewActiveWorkoutState).exercises.isNotEmpty) {
      NewActiveWorkoutState currentState = state as NewActiveWorkoutState;

      NewActiveWorkoutState generatedState =
          currentState.copyWith(workoutDuration: workoutDuration);

      emit(generatedState);
    } else {
      StateError("Cannot update state: $state != NewActiveWorkoutState");
    }
  }

  loadCompleteWorkoutToState(LoadedWorkoutModel completeWorkout) {
    // print("we loading complete workout ${completeWorkout.id} to state");
    LoadedActiveWorkoutState completeLoadedWorkoutState =
        LoadedActiveWorkoutState(
            id: completeWorkout.id,
            day: completeWorkout.day,
            month: completeWorkout.month,
            year: completeWorkout.year,
            workoutStartTime: completeWorkout.workoutStartTime,
            workoutDuration: completeWorkout.workoutDuration,
            exercises: completeWorkout.exercises);

    emit(completeLoadedWorkoutState);
  }

  loadSavedJsonWorkoutToState(Map<String, dynamic> savedJsonWorkoutState) {
    NewActiveWorkoutState loadedState = NewActiveWorkoutState(
        day: savedJsonWorkoutState['day'],
        month: savedJsonWorkoutState['month'],
        year: savedJsonWorkoutState['year'],
        workoutStartTime: savedJsonWorkoutState['workoutStartTime'],
        workoutDuration: savedJsonWorkoutState['workoutDuration'],
        exercises: (savedJsonWorkoutState['exercises'] as List<dynamic>)
            .map((exercise) => NewExerciseModel.fromJson(exercise))
            .toList());

    emit(loadedState);
  }

  loadWorkoutToState(WorkoutTable loadedWorkout) {
    LoadedActiveWorkoutState loadedWorkoutState = LoadedActiveWorkoutState(
        id: loadedWorkout.id!,
        day: loadedWorkout.day,
        month: loadedWorkout.month,
        year: loadedWorkout.year,
        workoutStartTime: loadedWorkout.workoutStartTime,
        workoutDuration: loadedWorkout.duration,
        exercises: const []);

    emit(loadedWorkoutState);
  }

  loadExercisesToState(LoadedWorkoutModel loadedWorkout) {
    if (state is LoadedActiveWorkoutState) {
      LoadedActiveWorkoutState currentState = state as LoadedActiveWorkoutState;
      LoadedActiveWorkoutState generatedState =
          currentState.copyWith(loadedExercises: loadedWorkout.exercises);

      emit(generatedState);
    } else {
      StateError("Cannot load exercises to state: $state");
    }
  }
}
