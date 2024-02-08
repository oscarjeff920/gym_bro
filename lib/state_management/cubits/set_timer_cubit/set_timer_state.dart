import 'package:equatable/equatable.dart';

class SetTimerState extends Equatable {
  final int elapsed;

  const SetTimerState(this.elapsed);

  @override
  // Returning duration in MM:SS format
  String toString() {
    String hhmmss = Duration(seconds: elapsed).toString().split(".").first;
    return
      "${hhmmss.split(":").elementAt(1)}:${hhmmss.split(":").elementAt(2)}";
  }

  @override
  List<Object?> get props => [];
}

class SetTimerStarted extends SetTimerState {
  const SetTimerStarted(int elapsed) : super(elapsed);

  @override
  List<Object?> get props => [elapsed];
}

class SetTimerStopped extends SetTimerState {
  const SetTimerStopped(int elapsed) : super(elapsed);
}

class SetTimerReset extends SetTimerState {
  const SetTimerReset() : super(0);
}
