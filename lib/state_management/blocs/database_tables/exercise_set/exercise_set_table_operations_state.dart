import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';

class ExerciseSetTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExerciseSetTableNotQueriedState extends ExerciseSetTableOperationsState {}

class ExerciseSetTableQueryState extends ExerciseSetTableOperationsState {}

class ExerciseSetTableSuccessfulQueryAllByExerciseIdState
    extends ExerciseSetTableQueryState {
  final List<LoadedExerciseModel> completeWorkoutExercises;

  ExerciseSetTableSuccessfulQueryAllByExerciseIdState(
      {required this.completeWorkoutExercises});

  @override
  List<Object> get props => [completeWorkoutExercises];
}

class ExerciseSetTableQueryErrorState extends ExerciseSetTableQueryState {}
