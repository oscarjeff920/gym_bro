import 'package:equatable/equatable.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_state.dart';

class WorkoutTimerState extends Equatable{
  final int elapsed;

  const WorkoutTimerState(this.elapsed);

  @override
  String toString () {
    return Duration(seconds: elapsed).toString().split(".").first;
  }

  @override
  List<Object?> get props => [];
}

class WorkoutTimerStarted extends WorkoutTimerState{
  const WorkoutTimerStarted(int elapsed): super(elapsed);

  @override
  List<Object?> get props => [elapsed];
}

class WorkoutTimerStopped extends WorkoutTimerState{
  const WorkoutTimerStopped(int elapsed) : super(elapsed);
}

class WorkoutTimerReset extends WorkoutTimerState{
  const WorkoutTimerReset(): super(0);
}