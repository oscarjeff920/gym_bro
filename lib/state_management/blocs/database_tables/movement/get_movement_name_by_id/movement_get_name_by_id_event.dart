import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';

class MovementGetNameByIdEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QueryMovementNameByIdEvent extends MovementGetNameByIdEvent {
  final List<WorkoutPageExerciseModel> namelessExercises;

  QueryMovementNameByIdEvent({required this.namelessExercises});

  @override
  List<Object> get props => [namelessExercises];
}

class ResetMovementGetNameByIdEvent extends MovementGetNameByIdEvent {}
