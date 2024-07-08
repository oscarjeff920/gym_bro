import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';
import 'exercise_set_data_models.dart';

class WorkoutPageExerciseModel {
  final int? id;
  final int exerciseOrder;
  final String? movementName;
  final int movementId;
  final String? exerciseDuration;
  final int numWorkingSets;
  final Map<MuscleGroupType, RoleType> workedMuscleGroups;
  final List<ExerciseSetTable> exerciseSets;

  WorkoutPageExerciseModel({
    this.id,
    required this.exerciseOrder,
    this.movementName,
    required this.movementId,
    this.exerciseDuration,
    required this.numWorkingSets,
    required this.workedMuscleGroups,
    this.exerciseSets = const [],
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> modelAsMap = {
      'id': id,
      'exerciseOrder': exerciseOrder,
      'movementName': movementName,
      'movementId': movementId,
      'exerciseDuration': exerciseDuration,
      'numWorkingSets': numWorkingSets,
      'primaryMuscleGroup': returnPrimaryMuscleGroup().first.name,
      'exerciseSets':
      exerciseSets.map((exerciseSet) => exerciseSet.toMap()).toList()
    };

    return modelAsMap;
  }

  factory WorkoutPageExerciseModel.fromExerciseTableWithWorkedMuscleGroups(
      ExerciseTableWithWorkedMuscleGroups model) {
    WorkoutPageExerciseModel generatedModel = WorkoutPageExerciseModel(
      id: model.id,
      exerciseOrder: model.exerciseOrder,
      movementId: model.movementId,
      exerciseDuration: model.duration,
      numWorkingSets: model.numWorkingSets,
      workedMuscleGroups: model.workedMuscleGroups,
    );
    return generatedModel;
  }

  WorkoutPageExerciseModel copyWith({
    required WorkoutPageExerciseModel currentModel,
    int? id,
    int? exerciseOrder,
    String? movementName,
    int? movementId,
    String? exerciseDuration,
    int? numWorkingSets,
    Map<MuscleGroupType, RoleType>? workedMuscleGroups,
    List<ExerciseSetTable>? exerciseSets,
  }) {
    WorkoutPageExerciseModel generatedState = WorkoutPageExerciseModel(
      id: id ?? currentModel.id,
      exerciseOrder: exerciseOrder ?? currentModel.exerciseOrder,
      movementName: movementName ?? currentModel.movementName,
      movementId: movementId ?? currentModel.movementId,
      exerciseDuration: exerciseDuration ?? currentModel.exerciseDuration,
      numWorkingSets: numWorkingSets ?? currentModel.numWorkingSets,
      workedMuscleGroups: workedMuscleGroups ?? currentModel.workedMuscleGroups,
      exerciseSets: exerciseSets ?? currentModel.exerciseSets,
    );
    return generatedState;
  }

  int getWorkingSetsPerMuscleGroup(MuscleGroupType muscleGroup) {
    if (workedMuscleGroups.containsKey(muscleGroup)) {
      if (workedMuscleGroups[muscleGroup] == RoleType.primary) {
        return numWorkingSets;
      }
      return (numWorkingSets / 4).floor();
    }
    return 0;
  }

  List<MuscleGroupType> returnPrimaryMuscleGroup() {
    List<MuscleGroupType> primaryMuscleGroups = [];
    for (var muscleGroup in workedMuscleGroups.entries) {
      if (muscleGroup.value == RoleType.primary) {
        primaryMuscleGroups.add(muscleGroup.key);
      }
    }
    return primaryMuscleGroups;
  }

  List<MuscleGroupType> returnSecondaryMuscleGroups() {
    List<MuscleGroupType> secondaryMuscleGroups = [];
    for (var muscleGroup in workedMuscleGroups.entries) {
      if (muscleGroup.value == RoleType.secondary) {
        secondaryMuscleGroups.add(muscleGroup.key);
      }
    }
    return secondaryMuscleGroups;
  }
}

class GeneralExerciseModel {
  final int? id;
  final int? exerciseOrder;
  final String movementName;
  final int? movementId;
  final String? exerciseDuration;
  final int? numWorkingSets;
  final Map<MuscleGroupType, RoleType> workedMuscleGroups;

  // final MuscleGroupType secondaryMuscleGroup;
  final List<GeneralExerciseSetModel> exerciseSets;

  GeneralExerciseModel(
      {this.id,
      this.exerciseOrder,
      required this.movementName,
      required this.movementId,
      this.exerciseDuration,
      this.numWorkingSets,
      required this.workedMuscleGroups,
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
  final Map<MuscleGroupType, RoleType> workedMuscleGroups;

  // final MuscleGroupType secondaryMuscleGroup;
  final List<LoadedExerciseSetModel> exerciseSets;

  LoadedExerciseModel({
    required this.id,
    required this.exerciseOrder,
    required this.movementName,
    required this.movementId,
    required this.exerciseDuration,
    required this.numWorkingSets,
    required this.workedMuscleGroups,
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
      workedMuscleGroups: {},
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
        workedMuscleGroups: workedMuscleGroups,
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
  final Map<MuscleGroupType, RoleType> workedMuscleGroups;

  // final MuscleGroupType secondaryMuscleGroup;
  final List<NewExerciseSetModel> exerciseSets;

  NewExerciseModel(
      {this.exerciseOrder,
      required this.movementName,
      this.movementId,
      this.exerciseDuration,
      this.numWorkingSets,
      required this.workedMuscleGroups,
      // required this.secondaryMuscleGroup,
      required this.exerciseSets});

  GeneralExerciseModel transformToGeneralModel() {
    GeneralExerciseModel convertedModel = GeneralExerciseModel(
        exerciseOrder: exerciseOrder,
        movementName: movementName,
        movementId: movementId,
        numWorkingSets: numWorkingSets,
        workedMuscleGroups: workedMuscleGroups,
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
      'primaryMuscleGroup': workedMuscleGroups.toString().split(".").last,
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
      workedMuscleGroups: {},
      exerciseSets: (json['exerciseSets'] as List)
          .map((setJson) => NewExerciseSetModel.fromJson(setJson))
          .toList(),
    );
  }
}
