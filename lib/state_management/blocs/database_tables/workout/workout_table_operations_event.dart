import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class WorkoutTableOperationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class QueryAllWorkoutTableEvent extends WorkoutTableOperationsEvent{}

class InsertNewWorkoutIntoTableEvent extends WorkoutTableOperationsEvent{
  final NewWorkoutModel newWorkout;

  InsertNewWorkoutIntoTableEvent({required this.newWorkout});
}
