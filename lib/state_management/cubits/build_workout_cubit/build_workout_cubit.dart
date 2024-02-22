import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/build_workout_cubit/build_workout_state.dart';

class BuildWorkoutCubit extends Cubit<BuildWorkoutState>{
  BuildWorkoutCubit() : super(const BuildWorkoutState());

  buildNewWorkout() {
    DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    emit(NewWorkoutState(date: dateToday));
  }

}