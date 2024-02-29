import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class ExerciseTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExerciseTableNotQueriedState extends ExerciseTableOperationsState {}

class ExerciseTableQueryState extends ExerciseTableOperationsState {}

class ExerciseTableSuccessfulQueryAllByWorkoutIdState
    extends ExerciseTableQueryState {
  final WorkoutModel_WorkoutPage selectedWorkout;
  final List<ExerciseModel_WorkoutPage> allExercisesQuery;

  ExerciseTableSuccessfulQueryAllByWorkoutIdState(
      {required this.selectedWorkout, required this.allExercisesQuery});

  @override
  List<Object> get props => [allExercisesQuery];
}

class ExerciseTableQueryErrorState extends ExerciseTableQueryState {}
