import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';

class MovementGetByMuscleGroupState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovementGetByMuscleGroupNotQueriedState extends MovementGetByMuscleGroupState{
}

class MovementGetByMuscleGroupQueryState extends MovementGetByMuscleGroupState {
}

class MovementGetByMuscleGroupSuccessfulQueryState extends MovementGetByMuscleGroupState{
  final List<MovementMuscleGroupJoin> fetchedMovementsList;

  MovementGetByMuscleGroupSuccessfulQueryState({required this.fetchedMovementsList});
}

class MovementGetByMuscleGroupQueryErrorState extends MovementGetByMuscleGroupState{
  final Object error;

  MovementGetByMuscleGroupQueryErrorState({required this.error});

}