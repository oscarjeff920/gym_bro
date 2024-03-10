import 'package:gym_bro/constants/enums.dart';

import 'exercise_data_models.dart';

class GeneralWorkoutModel {
  final int day;
  final int month;
  final int year;
  final String? workoutDuration;

  GeneralWorkoutModel(
      {
      required this.day,
      required this.month,
      required this.year,
      this.workoutDuration,
      });
}

// ===================================

class LoadedWorkoutModel extends GeneralWorkoutModel {
  final int id;
  final List<LoadedExerciseModel> exercises;

  LoadedWorkoutModel(
      {required this.id,
      required super.day,
      required super.month,
      required super.year,
      required super.workoutDuration,
      required this.exercises});
}

class NewWorkoutModel extends GeneralWorkoutModel{
  final List<NewExerciseModel> exercises;

  NewWorkoutModel(
      {required super.day,
      required super.month,
      required super.year,
        super.workoutDuration,
      required this.exercises});
}

// ===== OLD =======================>

// ignore: camel_case_types
class WorkoutModel_HomePage {
  final int? id;
  final int year;
  final int month;
  final int day;
  final String workoutDuration;
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
  final String workoutDuration;

  WorkoutModel_WorkoutPage(
      {required this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.workoutDuration});
}
