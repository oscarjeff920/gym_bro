import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';

class MovementByMuscleGroupEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class QueryMovementByPrimaryMuscleEvent extends MovementByMuscleGroupEvent{
  final MuscleGroupType selectedMuscleGroup;

  QueryMovementByPrimaryMuscleEvent({required this.selectedMuscleGroup});
}

class QueryMostRecentExerciseByMovementEvent extends MovementByMuscleGroupEvent{
  final int movementId;

  QueryMostRecentExerciseByMovementEvent({required this.movementId});

}

class ResetMovementByMuscleGroupEvent extends MovementByMuscleGroupEvent{}
