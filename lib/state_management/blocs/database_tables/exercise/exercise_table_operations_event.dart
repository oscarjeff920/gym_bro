import 'package:equatable/equatable.dart';

class ExerciseTableOperationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QueryAllExerciseByWorkoutIdEvent extends ExerciseTableOperationsEvent{
  final int workoutId;

  QueryAllExerciseByWorkoutIdEvent({required this.workoutId});

  @override
  List<Object> get props => [workoutId];
}