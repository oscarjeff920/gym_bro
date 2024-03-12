import 'exercise_data_models.dart';

class GeneralWorkoutModel {
  final int day;
  final int month;
  final int year;
  final String? workoutStartTime;
  final String? workoutDuration;

  GeneralWorkoutModel({
    required this.day,
    required this.month,
    required this.year,
    this.workoutStartTime,
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
      required super.workoutStartTime,
      required super.workoutDuration,
      required this.exercises});
}

class NewWorkoutModel extends GeneralWorkoutModel {
  final List<NewExerciseModel> exercises;

  NewWorkoutModel(
      {required super.day,
      required super.month,
      required super.year,
      super.workoutStartTime,
      super.workoutDuration,
      required this.exercises});
}
