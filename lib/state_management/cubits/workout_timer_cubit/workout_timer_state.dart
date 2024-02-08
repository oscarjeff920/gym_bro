import 'package:equatable/equatable.dart';

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
  const WorkoutTimerStopped() : super(0);
}