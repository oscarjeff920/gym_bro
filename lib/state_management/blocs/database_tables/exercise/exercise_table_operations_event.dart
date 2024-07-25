import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';

class ExerciseTableOperationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetExerciseQueryEvent extends ExerciseTableOperationsEvent{}

class QueryExercisesMovementNameEvent extends ExerciseTableOperationsEvent{
  final GeneralWorkoutPageExerciseModel namelessExercises;

  QueryExercisesMovementNameEvent({required this.namelessExercises});
}

class QueryAllExerciseByWorkoutEvent extends ExerciseTableOperationsEvent{
  final WorkoutTable selectedWorkout;

  QueryAllExerciseByWorkoutEvent({required this.selectedWorkout});

  @override
  List<Object> get props => [selectedWorkout];
}