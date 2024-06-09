import 'package:equatable/equatable.dart';

class GetLastExerciseSetsByMovementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QueryLastExerciseSetsByMovementEvent
    extends GetLastExerciseSetsByMovementEvent {
  final int movementId;

  QueryLastExerciseSetsByMovementEvent({required this.movementId});
}

class ResetGetLastExerciseSetsByMovementEvent
    extends GetLastExerciseSetsByMovementEvent {}
