import 'package:gym_bro/constants/enums.dart';
import 'exercise_set_data_models.dart';

class GeneralExerciseModel {
  final int? id;
  final int? exerciseOrder;
  final String movementName;
  final int? movementId;
  final String? exerciseDuration;
  final int? numWorkingSets;
  final MuscleGroupType primaryMuscleGroup;

  // final MuscleGroupType secondaryMuscleGroup;
  final List<GeneralExerciseSetModel> exerciseSets;

  GeneralExerciseModel(
      {this.id,
      this.exerciseOrder,
      required this.movementName,
      required this.movementId,
      this.exerciseDuration,
      this.numWorkingSets,
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
  final String? exerciseDuration;
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
    LoadedExerciseModel convertedExercise = LoadedExerciseModel(
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
    return convertedExercise;
  }

  GeneralExerciseModel transformToGeneralModel() {
    GeneralExerciseModel convertedModel = GeneralExerciseModel(
        id: id,
        exerciseOrder: exerciseOrder,
        movementName: movementName,
        movementId: movementId,
        exerciseDuration: exerciseDuration,
        numWorkingSets: numWorkingSets,
        primaryMuscleGroup: primaryMuscleGroup,
        exerciseSets: exerciseSets
            .map((exerciseSets) => exerciseSets.transformToGeneralModel())
            .toList());

    return convertedModel;
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

  GeneralExerciseModel transformToGeneralModel() {
    GeneralExerciseModel convertedModel = GeneralExerciseModel(
        exerciseOrder: exerciseOrder,
        movementName: movementName,
        movementId: movementId,
        numWorkingSets: numWorkingSets,
        primaryMuscleGroup: primaryMuscleGroup,
        exerciseSets: exerciseSets
            .map((exerciseSets) => exerciseSets.transformToGeneralModel())
            .toList());

    return convertedModel;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> modelAsMap = {
      'exerciseOrder': exerciseOrder,
      'movementName': movementName,
      'movementId': movementId,
      'exerciseDuration': exerciseDuration,
      'numWorkingSets': numWorkingSets,
      'primaryMuscleGroup': primaryMuscleGroup.toString().split(".").last,
      'exerciseSets':
          exerciseSets.map((exerciseSet) => exerciseSet.toMap()).toList()
    };

    return modelAsMap;
  }

  factory NewExerciseModel.fromJson(Map<String, dynamic> json) {
    return NewExerciseModel(
      exerciseOrder: json['exerciseOrder'],
      movementName: json['movementName'],
      movementId: json['movementId'],
      exerciseDuration: json['exerciseDuration'],
      numWorkingSets: json['numWorkingSets'],
      primaryMuscleGroup:
          MuscleGroupType.values.byName(json['primaryMuscleGroup']),
      exerciseSets: (json['exerciseSets'] as List)
          .map((setJson) => NewExerciseSetModel.fromJson(setJson))
          .toList(),
    );
  }
}
