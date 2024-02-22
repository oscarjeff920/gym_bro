import 'package:gym_bro/constants/enums.dart';

import 'exercise_set_data_models.dart';

// ignore: camel_case_types
class ExerciseModel_WorkoutPage {
  final int? id;

  // final Movement movement;
  // final List<MuscleGroupType> usedMuscles

  final int totalWorkingSets;
  final Duration exerciseTotalDuration;
  final int exerciseOrder;

  ExerciseModel_WorkoutPage(
      {this.id,
      required this.totalWorkingSets,
      required this.exerciseTotalDuration,
      required this.exerciseOrder});
}

// ignore: camel_case_types
class ExerciseModel_ExerciseModal {
  final MuscleGroupType muscleGroup;
  final dynamic movement;
  final int totalWorkingSets;
  final List<ExerciseSetModel_ExerciseModal> allExerciseSets;

  ExerciseModel_ExerciseModal(
      {required this.muscleGroup,
      required this.movement,
      required this.totalWorkingSets,
      required this.allExerciseSets});
}
