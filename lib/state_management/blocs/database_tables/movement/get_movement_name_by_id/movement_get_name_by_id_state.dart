import 'package:equatable/equatable.dart';

abstract class MovementGetNameByIdState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovementGetNameByIdNotQueriedState extends MovementGetNameByIdState {}

class MovementGetNameByIdQueryState extends MovementGetNameByIdState {}

class MovementGetNameByIdSuccessfulQueryState extends MovementGetNameByIdState {
  final Map<int, String> exerciseMovementNameIndex;

  MovementGetNameByIdSuccessfulQueryState({required this.exerciseMovementNameIndex});

  @override
  List<Object> get props => [exerciseMovementNameIndex];
}

class MovementGetNameByIdQueryErrorState extends MovementGetNameByIdState {
  final Object error;

  MovementGetNameByIdQueryErrorState({required this.error});

  @override
  List<Object> get props => [error];
}