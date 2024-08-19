import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class WorkoutTimerCubit extends Cubit<WorkoutTimerState> {
  WorkoutTimerCubit() : super(const WorkoutTimerReset());

  Timer? _timer;

  beginTimer([int? time]) {
    switch (state) {
      case WorkoutTimerReset():
        if (time != null) {
          emit(WorkoutTimerStarted(time));
        } else {
          emit(const WorkoutTimerStarted(0));
        }
        _timer = Timer.periodic(const Duration(seconds: 1), onTick);
      default:
        // timer already running
    }
  }

  returnTimed() {
    return Duration(seconds: state.elapsed);
  }

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
    if (_timer != null) {
      _timer!.cancel();
    }
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

  setTimer(String alreadyElapsedString) {
    List<String> splitDuration = alreadyElapsedString.split(":");

    int hoursElapsed = int.parse(splitDuration.first) * 3600;
    int minutesElapsed = int.parse(splitDuration.elementAt(1)) * 60;
    int secondsElapsed = int.parse(splitDuration.last);

    int totalSecondsElapsed = hoursElapsed + minutesElapsed + secondsElapsed;

    emit(WorkoutTimerStopped(totalSecondsElapsed));
  }
}
