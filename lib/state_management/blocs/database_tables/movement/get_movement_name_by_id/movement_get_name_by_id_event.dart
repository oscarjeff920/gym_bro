import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';

class MovementGetNameByIdEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QueryMovementNameByIdEvent extends MovementGetNameByIdEvent {
  final List<ExerciseTableWithWorkedMuscleGroups> namelessExercises;

  QueryMovementNameByIdEvent({required this.namelessExercises});

  @override
  List<Object> get props => [namelessExercises];
}

class ResetMovementGetNameByIdEvent extends MovementGetNameByIdEvent {}
