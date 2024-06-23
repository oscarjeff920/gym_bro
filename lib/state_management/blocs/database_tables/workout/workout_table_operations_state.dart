import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class WorkoutTableOperationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class WorkoutTableNotQueriedState extends WorkoutTableOperationsState {}

// all other states that deal with steps of the query will inherit from this state
// this way it'll be easy to distinguish between the initial non-queried state
// to the subsequent states for each stage of the query
class WorkoutTableQueryState extends WorkoutTableOperationsState {}

class WorkoutTableSuccessfulQueryState extends WorkoutTableQueryState {}

class WorkoutTableSuccessfulQueryAllState
    extends WorkoutTableSuccessfulQueryState {
  final Map<DateTime, Map<int, List<LoadedWorkoutModel>>> allWorkoutsQuery;

  WorkoutTableSuccessfulQueryAllState({required this.allWorkoutsQuery});
}

class WorkoutTableQueryErrorState extends WorkoutTableQueryState {}

// =================================

class WorkoutTableInsertState extends WorkoutTableOperationsState {}

class WorkoutTableSuccessfulInsertState extends WorkoutTableInsertState {}

class WorkoutTableSuccessfulNewWorkoutInsertState
    extends WorkoutTableSuccessfulInsertState {}

class WorkoutTableInsertErrorState extends WorkoutTableInsertState {
  final Object error;
  final NewWorkoutModel insertWorkout;

  WorkoutTableInsertErrorState({required this.error, required this.insertWorkout});
}
