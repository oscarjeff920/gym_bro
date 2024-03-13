import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';

class ExerciseSetTableOperationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetExerciseSetQueryEvent extends ExerciseSetTableOperationsEvent{}

class QueryAllExerciseSetsByExerciseEvent extends ExerciseSetTableOperationsEvent{
  final List<LoadedExerciseModel> workoutExercises;

  QueryAllExerciseSetsByExerciseEvent({required this.workoutExercises});

  @override
  List<Object> get props => [workoutExercises];
}