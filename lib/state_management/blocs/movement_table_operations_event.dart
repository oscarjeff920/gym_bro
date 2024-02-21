import 'package:equatable/equatable.dart';
import 'package:gym_bro/FE_consts/enums.dart';

abstract class MovementTableOperationsEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class QueryMovementByPrimaryMuscleEvent extends MovementTableOperationsEvent{
  final MuscleGroupType selectedMuscleGroup;

  QueryMovementByPrimaryMuscleEvent({required this.selectedMuscleGroup});
}
