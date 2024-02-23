import 'package:equatable/equatable.dart';

class WorkoutPageWorkoutState extends Equatable {
  final int year;
  final int month;
  final int day;

  const WorkoutPageWorkoutState(
      {required this.year, required this.month, required this.day});

  @override
  List<Object?> get props => [year, month, day];
}

class NewWorkoutState extends WorkoutPageWorkoutState {
  const NewWorkoutState(
      {required super.year, required super.month, required super.day});
}

class LoadWorkoutState extends WorkoutPageWorkoutState {
  final int id;
  final Duration workoutDuration;

  const LoadWorkoutState(
      {required super.year,
      required super.month,
      required super.day,
      required this.id,
      required this.workoutDuration});
}
