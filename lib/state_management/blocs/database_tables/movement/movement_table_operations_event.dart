import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';

class MovementTableOperationsEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class QueryMovementByPrimaryMuscleEvent extends MovementTableOperationsEvent{
  final MuscleGroupType selectedMuscleGroup;

  QueryMovementByPrimaryMuscleEvent({required this.selectedMuscleGroup});
}

class ResetMovementTableQueryEvent extends MovementTableOperationsEvent{}
