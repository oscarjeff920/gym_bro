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

  List<WorkoutModel_HomePage> convertWorkoutsForHomePage() {
    return allWorkoutsQuery
        .map((workout) => WorkoutModel_HomePage(
            id: workout.id,
            year: workout.year,
            month: workout.month,
            day: workout.day,
            workoutDuration: workout.duration))
        .toList();
  }
}

class WorkoutTableQueryErrorState extends WorkoutTableQueryState {}
