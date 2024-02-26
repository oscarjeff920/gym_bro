import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';

class ExerciseTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExerciseTableNotQueriedState extends ExerciseTableOperationsState {}

class ExerciseTableQueryState extends ExerciseTableOperationsState {}

class ExerciseTableSuccessfulQueryState extends ExerciseTableOperationsState {}

class ExerciseTableSuccessfulQueryAllState
    extends ExerciseTableSuccessfulQueryState {
  final List<ExerciseTable> allExercisesQuery;

  ExerciseTableSuccessfulQueryAllState({required this.allExercisesQuery});

  @override
  List<Object> get props => [allExercisesQuery];
}

class ExerciseTableQueryErrorState extends ExerciseTableOperationsState {}
