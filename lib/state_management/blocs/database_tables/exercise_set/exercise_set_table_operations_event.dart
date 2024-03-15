import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class ExerciseSetTableOperationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetExerciseSetQueryEvent extends ExerciseSetTableOperationsEvent{}

class QueryAllExerciseSetsByExerciseEvent extends ExerciseSetTableOperationsEvent{
  final LoadedWorkoutModel selectedWorkout;

  QueryAllExerciseSetsByExerciseEvent({required this.selectedWorkout});

  @override
  List<Object> get props => [selectedWorkout];
}