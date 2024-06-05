import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';

class GetMovementIdBlocEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class PassMovementDetailsEvent extends GetMovementIdBlocEvents {
  final String movementName;
  final MuscleGroupType muscleGroup;

  // final int muscleGroupId;

  PassMovementDetailsEvent(
      {required this.movementName, required this.muscleGroup});

  @override
  List<Object> get props => [movementName, muscleGroup];
}

class PassFinalMovementNameEvent extends GetMovementIdBlocEvents {
  final String movementName;
  final int? movementId;
  final MuscleGroupType primaryMuscleGroup;

  PassFinalMovementNameEvent(
      {required this.movementName,
      required this.movementId,
      required this.primaryMuscleGroup});

  @override
  List<Object> get props => [movementName];
}

class ResetGetMovementIdEvent extends GetMovementIdBlocEvents {}
