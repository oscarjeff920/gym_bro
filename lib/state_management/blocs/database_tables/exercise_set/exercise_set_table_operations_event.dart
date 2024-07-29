import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';

class ExerciseSetTableOperationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetExerciseSetQueryEvent extends ExerciseSetTableOperationsEvent{}

class QueryAllExerciseSetsByExerciseEvent extends ExerciseSetTableOperationsEvent{
  final List<ExerciseTableWithWorkedMuscleGroups> setlessExercises;

  QueryAllExerciseSetsByExerciseEvent({required this.setlessExercises});

  @override
  List<Object> get props => [setlessExercises];
}