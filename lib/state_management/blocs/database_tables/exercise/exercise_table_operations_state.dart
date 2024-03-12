import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class ExerciseTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExerciseTableNotQueriedState extends ExerciseTableOperationsState {}

class ExerciseTableQueryState extends ExerciseTableOperationsState {}

class ExerciseTableSuccessfulQueryAllByWorkoutIdState
    extends ExerciseTableQueryState {
  final LoadedWorkoutModel selectedWorkout;

  ExerciseTableSuccessfulQueryAllByWorkoutIdState(
      {required this.selectedWorkout});

  @override
  List<Object> get props => [selectedWorkout];
}

class ExerciseTableQueryErrorState extends ExerciseTableQueryState {}
