import 'package:equatable/equatable.dart';
import '../../../../database/data_models/joined_tables/movement_muscle_group_join_object.dart';

class MovementTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovementTableNotQueriedState extends MovementTableOperationsState{
}

class MovementTableQueryState extends MovementTableOperationsState {
}

class MovementTableSuccessfulQueryState extends MovementTableOperationsState{
  final List<MovementMuscleGroupJoin> queryResponse;

  MovementTableSuccessfulQueryState({required this.queryResponse});
}

class MovementTableQueryErrorState extends MovementTableOperationsState{

}