import 'package:gym_bro/constants/enums.dart';
import 'exercise_set_data_models.dart';

class GeneralExerciseModel {
  final int? id;
  final int exerciseOrder;
  final String movementName;
  final int movementId;
  final String exerciseDuration;
  final int numWorkingSets;
  final MuscleGroupType primaryMuscleGroup;

  // final MuscleGroupType secondaryMuscleGroup;
  final List<LoadedExerciseSetModel> exerciseSets;

  GeneralExerciseModel(
      {this.id,
      required this.exerciseOrder,
      required this.movementName,
      required this.movementId,
      required this.exerciseDuration,
      required this.numWorkingSets,
      required this.primaryMuscleGroup,
      // required this.secondaryMuscleGroup,
      required this.exerciseSets});
}

// ===================================

class LoadedExerciseModel {
  final int id;
  final int exerciseOrder;
  final String movementName;
  final int movementId;
  final String exerciseDuration;
  final int numWorkingSets;
  final MuscleGroupType primaryMuscleGroup;

  // final MuscleGroupType secondaryMuscleGroup;
  final List<LoadedExerciseSetModel> exerciseSets;

  LoadedExerciseModel({
    required this.id,
    required this.exerciseOrder,
    required this.movementName,
    required this.movementId,
    required this.exerciseDuration,
    required this.numWorkingSets,
    required this.primaryMuscleGroup,
    // required this.secondaryMuscleGroup
    required this.exerciseSets,
  });

  factory LoadedExerciseModel.fromMap(Map<String, dynamic> map) {
    // print(map);
    return LoadedExerciseModel(
      id: map['id'],
      exerciseOrder: map['exercise_order'],
      movementName: map['movement_name'],
      movementId: map['movement_id'],
      exerciseDuration: map['exercise_duration'],
      numWorkingSets: map['num_working_sets'],
      primaryMuscleGroup:
          MuscleGroupType.values.byName(map['primary_muscle_group_name']),
      // secondaryMuscleGroup: secondaryMuscleGroup,
      exerciseSets: [],
    );
  }
}

class NewExerciseModel {
  final int? exerciseOrder;
  final String movementName;
  final int? movementId;
  final String? exerciseDuration;
  final int? numWorkingSets;
  final MuscleGroupType primaryMuscleGroup;

  // final MuscleGroupType secondaryMuscleGroup;
  final List<NewExerciseSetModel> exerciseSets;

  NewExerciseModel(
      {this.exerciseOrder,
      required this.movementName,
      this.movementId,
      this.exerciseDuration,
      this.numWorkingSets,
      required this.primaryMuscleGroup,
      // required this.secondaryMuscleGroup,
      required this.exerciseSets});
}

// ===== OLD =======================>

// ignore: camel_case_types
class ExerciseModel_WorkoutPage {
  final int? id;
  final int exerciseOrder;
  final String movementName;
  final int movementId;
  final String exerciseDuration;
  final int numWorkingSets;
  final MuscleGroupType primaryMuscleGroup;

  // final MuscleGroupType secondaryMuscleGroup;

  ExerciseModel_WorkoutPage({
    required this.id,
    required this.exerciseOrder,
    required this.movementName,
    required this.movementId,
    required this.exerciseDuration,
    required this.numWorkingSets,
    required this.primaryMuscleGroup,
    // required this.secondaryMuscleGroup
  });

  factory ExerciseModel_WorkoutPage.fromMap(Map<String, dynamic> map) {
    // print(map);
    return ExerciseModel_WorkoutPage(
      id: map['id'],
      exerciseOrder: map['exercise_order'],
      movementName: map['name'],
      movementId: map['movement_id'],
      exerciseDuration: map['duration'],
      numWorkingSets: map['num_working_sets'],
      primaryMuscleGroup:
          MuscleGroupType.values.byName(map['primary_muscle_group_name']),
      // secondaryMuscleGroup:
      //     MuscleGroupType.values.byName(map['secondary_muscle_group_name'])
    );
  }
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
