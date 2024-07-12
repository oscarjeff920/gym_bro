import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';

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

  factory LoadedWorkoutModel.fromTableModel(WorkoutTable tableObj,
      {List<LoadedExerciseModel> exercises = const []}) {
    LoadedWorkoutModel generatedModel = LoadedWorkoutModel(
        id: tableObj.id!,
        day: tableObj.day,
        month: tableObj.month,
        year: tableObj.year,
        workoutStartTime: tableObj.workoutStartTime,
        workoutDuration: tableObj.duration ?? "- - - -",
        exercises: exercises);
    return generatedModel;
  }
}

class NewWorkoutModel extends GeneralWorkoutModel {
  final List<WorkoutPageExerciseModel> exercises;

  NewWorkoutModel(
      {required super.day,
      required super.month,
      required super.year,
      super.workoutStartTime,
      super.workoutDuration,
      required this.exercises});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> modelAsMap = {
      'day': day,
      'month': month,
      'year': year,
      'workoutStartTime': workoutStartTime,
      'workoutDuration': workoutDuration,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList()
    };

    return modelAsMap;
  }
}
