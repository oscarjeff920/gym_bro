import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_state.dart';

class SetTimerCubit extends Cubit<SetTimerState> {
  SetTimerCubit() : super(const SetTimerReset());

  Timer? _timer;

  returnTimed() {
    if (state.elapsed == 0) return null;
    return Duration(seconds: state.elapsed);
  }

  startTimer() {
    emit(const SetTimerStarted(0));

    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      emit(SetTimerStopped(state.elapsed));
    }
  }

  resetTimer() {
    switch (state) {
      case SetTimerReset():
        null;
      default:
        emit(const SetTimerReset());
    }
  }

  onTick(Timer timer) {
    switch (state) {
      case SetTimerStarted():
        emit(SetTimerStarted(state.elapsed + 1));
    }
  }
}
