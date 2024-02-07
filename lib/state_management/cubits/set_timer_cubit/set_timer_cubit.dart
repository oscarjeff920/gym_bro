import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_state.dart';

class SetTimerCubit extends Cubit<SetTimerState> {
  SetTimerCubit() : super(const SetTimerReset());

  Timer? _timer;

  startTimer(){
    emit( const SetTimerStarted(0));
    print("\n=============\n          tick-tock\n================\n");

    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  stopTimer() {
    _timer!.cancel();
    emit(SetTimerStopped(state.elapsed));
  }

  onTick(Timer timer) {
    switch (state) {
      case SetTimerStarted():
        emit(SetTimerStarted(state.elapsed + 1));
    }
  }

}