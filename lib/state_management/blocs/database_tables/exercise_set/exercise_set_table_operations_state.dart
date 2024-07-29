import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';

class ExerciseSetTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExerciseSetTableNotQueriedState extends ExerciseSetTableOperationsState {}

class ExerciseSetTableQueryState extends ExerciseSetTableOperationsState {}

class ExerciseSetTableSuccessfulQueryAllByExerciseIdState
    extends ExerciseSetTableQueryState {
  final Map<int, List<ExerciseSetTable>> exerciseSetsExerciseIndex;

  ExerciseSetTableSuccessfulQueryAllByExerciseIdState(
      {required this.exerciseSetsExerciseIndex});

  @override
  List<Object> get props => [exerciseSetsExerciseIndex];
}

class ExerciseSetTableQueryErrorState extends ExerciseSetTableQueryState {
  final Object error;

  ExerciseSetTableQueryErrorState({required this.error});
}
