import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';

class ExerciseSetTableOperationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetExerciseSetQueryEvent extends ExerciseSetTableOperationsEvent{}

class QueryAllExerciseSetsByExerciseEvent extends ExerciseSetTableOperationsEvent{
  final List<WorkoutPageExerciseModel> setlessExercises;

  QueryAllExerciseSetsByExerciseEvent({required this.setlessExercises});

  @override
  List<Object> get props => [setlessExercises];
}