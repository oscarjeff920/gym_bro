import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';

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
  final List<WorkoutTable> allWorkoutsQuery;

  WorkoutTableSuccessfulQueryAllState({required this.allWorkoutsQuery});

  List<LoadedWorkoutModel> convertWorkoutsForHomePage() {
    return allWorkoutsQuery
        .map((workout) => LoadedWorkoutModel(
            id: workout.id!,
            day: workout.day,
            month: workout.month,
            year: workout.year,
            workoutDuration: workout.duration,
            exercises: []))
        .toList();
  }
}

class WorkoutTableQueryErrorState extends WorkoutTableQueryState {}

// =================================

class WorkoutTableInsertState extends WorkoutTableOperationsState {}

class WorkoutTableSuccessfulInsertState extends WorkoutTableInsertState {}

class WorkoutTableSuccessfulNewWorkoutInsertState
    extends WorkoutTableSuccessfulInsertState {}

class WorkoutTableInsertErrorState extends WorkoutTableInsertState {}
