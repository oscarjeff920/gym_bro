import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

import 'workout_page_workout_state.dart';

class WorkoutPageWorkoutCubit extends Cubit<WorkoutPageWorkoutState> {
  WorkoutPageWorkoutCubit() : super(WorkoutPageWorkoutState());

  buildNewWorkout() {
    DateTime dateToday = DateTime.now();
    print("we building new workout! ${dateToday.year}/${dateToday.month}/${dateToday.day}");
    emit(NewWorkoutState(
        year: dateToday.year, month: dateToday.month, day: dateToday.day));
  }

  loadWorkout(WorkoutModel_HomePage workout) {
    emit(LoadWorkoutState(
        year: workout.year,
        month: workout.month,
        day: workout.day,
        id: workout.id!,
        workoutDuration: workout.workoutDuration));
  }
}
