import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';

class ActiveWorkoutCubit extends Cubit<ActiveWorkoutState> {
  ActiveWorkoutCubit() : super(ActiveWorkoutState());

  resetState() {
    emit(ActiveWorkoutState());
  }

  createNewWorkoutState() {
    DateTime dateToday = DateTime.now();

    emit(NewActiveWorkoutState(
        day: dateToday.day,
        month: dateToday.month,
        year: dateToday.year,
        exercises: []
    ));
  }

  updateNewWorkoutState({
    String? duration,
    List<NewExerciseModel>? newExercises
}) {
    if (state is NewActiveWorkoutState) {
      NewActiveWorkoutState currentState = state as NewActiveWorkoutState;
      NewActiveWorkoutState generatedState = currentState.copyWith(
        workoutDuration: duration,
        newExercises: newExercises
      );

      emit(generatedState);
    }
    else {
      StateError("Cannot update state: $state != NewActiveWorkoutState");
    }
  }

  loadWorkoutToState(WorkoutTable loadedWorkout) {
    print("=============\n=======> load Workout to state");
    LoadedActiveWorkoutState loadedWorkoutState = LoadedActiveWorkoutState(
    id: loadedWorkout.id!,
    day: loadedWorkout.day,
    month: loadedWorkout.month,
    year: loadedWorkout.year,
    workoutDuration: loadedWorkout.duration,
    exercises: const []);

    print('loadedWorkoutState : $loadedWorkoutState');
    emit(loadedWorkoutState);
  }

  loadExercisesToState(LoadedWorkoutModel loadedWorkout) {
    print("=============\n=======> Load exercises to state:");
    if (state is LoadedActiveWorkoutState) {
      LoadedActiveWorkoutState currentState = state as LoadedActiveWorkoutState;
      LoadedActiveWorkoutState generatedState = currentState.copyWith(loadedExercises: loadedWorkout.exercises);

      print('loaded exercises to state: $generatedState');
      emit(generatedState);
    }
    else {
      StateError("Cannot load exercises to state: $state");
    }


    // print("this is our loadedWorkout: $loadedWorkout");
    // var x = 0;
    // for (var exercise in loadedWorkout.exercises) {
    //   print("$x:${exercise.movementName} ");
    //   x += 1;
    // }
    // LoadedWorkoutState createdState = LoadedWorkoutState(
    //     id: loadedWorkout.id,
    //     day: loadedWorkout.day,
    //     month: loadedWorkout.month,
    //     year: loadedWorkout.year,
    //     workoutDuration: loadedWorkout.workoutDuration,
    //     loadedExercises: loadedWorkout.exercises
    // );
    // print("this is the state we're creating:\nLoadedWorkoutState: $createdState");
    // emit(createdState);
  }

  // addNewWorkoutToState() {
  //   DateTime dateToday = DateTime.now();
  //
  //   emit(NewWorkoutState(
  //       day: dateToday.day,
  //       month: dateToday.month,
  //       year: dateToday.year,
  //       newExercises: const []));
  // }
}
