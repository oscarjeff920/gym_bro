import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class WorkoutTimerCubit extends Cubit<WorkoutTimerState> {
  WorkoutTimerCubit() : super(const WorkoutTimerStopped());

  Timer? _timer;

  startTimer( [int? time] ){
    if (time != null) {
      emit(WorkoutTimerStarted(time));
    }
    else {
      emit( const WorkoutTimerStarted(0));
      print("emitted init state");
    }

    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  stopTimer() {
    _timer!.cancel();
  }

  onTick(Timer timer) {
    switch (state) {
      case WorkoutTimerStarted():
        emit(WorkoutTimerStarted(state.elapsed + 1));
    }
  }

}