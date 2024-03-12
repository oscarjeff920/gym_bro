import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class WorkoutTimerCubit extends Cubit<WorkoutTimerState> {
  WorkoutTimerCubit() : super(const WorkoutTimerReset());

  Timer? _timer;

  startTimer([int? time]) {
    if (state.elapsed == 0) {
      if (time != null) {
        emit(WorkoutTimerStarted(time));
      } else {
        emit(const WorkoutTimerStarted(0));
      }

      _timer = Timer.periodic(const Duration(seconds: 1), onTick);
    }
  }

  stopTimer() {
    _timer!.cancel();
    emit(WorkoutTimerStopped(state.elapsed));
  }

  resetTimer() {
    switch (state) {
      case WorkoutTimerReset():
        null;
      default:
        emit(const WorkoutTimerReset());
    }
  }

  onTick(Timer timer) {
    switch (state) {
      case WorkoutTimerStarted():
        emit(WorkoutTimerStarted(state.elapsed + 1));
    }
  }
}
