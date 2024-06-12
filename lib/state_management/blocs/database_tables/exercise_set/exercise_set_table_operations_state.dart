import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class ExerciseSetTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExerciseSetTableNotQueriedState extends ExerciseSetTableOperationsState {}

class ExerciseSetTableQueryState extends ExerciseSetTableOperationsState {}

class ExerciseSetTableSuccessfulQueryAllByExerciseIdState
    extends ExerciseSetTableQueryState {
  final LoadedWorkoutModel completeWorkout;

  ExerciseSetTableSuccessfulQueryAllByExerciseIdState(
      {required this.completeWorkout});

  @override
  List<Object> get props => [completeWorkout];
}

class ExerciseSetTableQueryErrorState extends ExerciseSetTableQueryState {
  final Object error;

  ExerciseSetTableQueryErrorState({required this.error});
}
