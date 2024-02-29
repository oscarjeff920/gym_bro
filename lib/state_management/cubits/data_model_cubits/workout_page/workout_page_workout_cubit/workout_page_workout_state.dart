import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';

class WorkoutPageWorkoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WorkoutPageGenerateState extends WorkoutPageWorkoutState {
  final int year;
  final int month;
  final int day;

  WorkoutPageGenerateState(
      {required this.year, required this.month, required this.day});

  @override
  List<Object> get props => [year, month, day];
}

class LoadWorkoutState extends WorkoutPageGenerateState {
  final int id;
  final String workoutDuration;

  LoadWorkoutState(
      {required this.id,
      required super.year,
      required super.month,
      required super.day,
      required this.workoutDuration});

  @override
  List<Object> get props => [id, year, month, day, workoutDuration];
}

class WorkoutPageDetailsState extends WorkoutPageGenerateState {
  final int? id;
  final String? workoutDuration;
  final List<ExerciseModel_WorkoutPage> exercises;

  WorkoutPageDetailsState(
      {this.id,
      required super.year,
      required super.month,
      required super.day,
      this.workoutDuration,
      required this.exercises});
}
