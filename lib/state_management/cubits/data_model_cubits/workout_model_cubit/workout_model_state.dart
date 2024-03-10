import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';

class WorkoutModelInitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WorkoutModelState extends WorkoutModelInitState {
  final int? id;
  final int day;
  final int month;
  final int year;
  final String? workoutDuration;
  final List<GeneralExerciseModel> exercises;

  WorkoutModelState(
      {this.id,
      required this.day,
      required this.month,
      required this.year,
      this.workoutDuration,
      required this.exercises});

  @override
  List<Object?> get props => [day, month, year, workoutDuration, exercises];
}

class NewWorkoutModelState extends WorkoutModelState {
  NewWorkoutModelState(
      {required super.day,
      required super.month,
      required super.year,
      super.workoutDuration,
      required super.exercises});
}

class LoadedWorkoutModelState extends WorkoutModelState {
  LoadedWorkoutModelState(
      {required super.id,
      required super.day,
      required super.month,
      required super.year,
      required super.workoutDuration,
      required super.exercises});

  @override
  List<Object?> get props => [id, day, month, year, workoutDuration, exercises];

}
