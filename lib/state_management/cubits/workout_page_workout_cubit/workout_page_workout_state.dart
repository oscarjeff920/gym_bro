import 'package:equatable/equatable.dart';

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
}

class NewWorkoutState extends WorkoutPageGenerateState {
  NewWorkoutState(
      {required super.year, required super.month, required super.day});
}

class LoadWorkoutState extends WorkoutPageGenerateState {
  final int id;
  final String workoutDuration;

  LoadWorkoutState(
      {required super.year,
      required super.month,
      required super.day,
      required this.id,
      required this.workoutDuration});
}
