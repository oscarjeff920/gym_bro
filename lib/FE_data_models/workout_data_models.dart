import 'package:gym_bro/constants/enums.dart';

import 'exercise_data_models.dart';

// ignore: camel_case_types
class WorkoutModel_HomePage {
  final int? id;
  final int year;
  final int month;
  final int day;
  final Duration workoutDuration;
  final MuscleGroupType? primaryMuscleType;

  WorkoutModel_HomePage(
      {this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.workoutDuration,
      this.primaryMuscleType});
}

// ignore: camel_case_types
class WorkoutModel_WorkoutPage {
  final int? id;
  final int year;
  final int month;
  final int day;
  final List<ExerciseModel_WorkoutPage> exercises;

  WorkoutModel_WorkoutPage(
      {required this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.exercises});
}
