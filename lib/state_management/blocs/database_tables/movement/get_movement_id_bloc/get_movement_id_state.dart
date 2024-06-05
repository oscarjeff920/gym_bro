import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';

class GetMovementIdInitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QueryingMovementTableState extends GetMovementIdInitState{
}

class QueryingErrorMovementTableState extends GetMovementIdInitState{
  final Object error;

  QueryingErrorMovementTableState({required this.error});
}

class CheckSimilarMovementNamesState extends GetMovementIdInitState{
  final String newMovementName;
  final List<MovementMuscleGroupJoin> similarDbMovementNames;

  CheckSimilarMovementNamesState(
      {required this.newMovementName, required this.similarDbMovementNames});
}

class ReceivedMovementIdState extends GetMovementIdInitState{
  final String movementName;
  final int movementId;

  ReceivedMovementIdState({required this.movementId, required this.movementName});
}
