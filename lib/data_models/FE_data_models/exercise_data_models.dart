import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';
import 'exercise_set_data_models.dart';

// This model is used to convert between a homepage exercise model
// to GeneralWorkoutPageExerciseModel
class SelectedWorkoutIntermittentExerciseModel {
  // db table fields
  final int id;
  final int workoutId;
  final int movementId;
  final int exerciseOrder;
  final String? exerciseDuration; // nullable as we're not enforcing recording
  final int numWorkingSets;

  // fetched fields
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  // additional fields
  final String? movementName;
  final List<GeneralExerciseSetModel> exerciseSets;

  SelectedWorkoutIntermittentExerciseModel({
    required this.id,
    required this.workoutId,
    required this.movementId,
    required this.exerciseOrder,
    this.exerciseDuration,
    required this.numWorkingSets,
    required this.workedMuscleGroups,

    // additional parameters
    this.movementName,
    this.exerciseSets = const [],
  });

  factory SelectedWorkoutIntermittentExerciseModel.fromExerciseTableWithWorkedMuscleGroups(
      ExerciseTableWithWorkedMuscleGroups exercise) {
    SelectedWorkoutIntermittentExerciseModel convertedModel =
        SelectedWorkoutIntermittentExerciseModel(
            id: exercise.id,
            workoutId: exercise.workoutId,
            movementId: exercise.movementId,
            exerciseOrder: exercise.exerciseOrder,
            numWorkingSets: exercise.numWorkingSets,
            workedMuscleGroups: exercise.workedMuscleGroups);

    return convertedModel;
  }

  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> modelAsMap = {
  //     'id': id,
  //     'exerciseOrder': exerciseOrder,
  //     'movementName': movementName,
  //     'movementId': movementId,
  //     'exerciseDuration': exerciseDuration,
  //     'numWorkingSets': numWorkingSets,
  //     'primaryMuscleGroup': workedMuscleGroups.returnPrimaryMuscleGroups().first.name,
  //     'exerciseSets':
  //     exerciseSets.map((exerciseSet) => exerciseSet.toMap()).toList()
  //   };
  //
  //   return modelAsMap;
  // }
  //
  // factory GeneralWorkoutPageExerciseModel.fromExerciseTableWithWorkedMuscleGroups(
  //     ExerciseTableWithWorkedMuscleGroups model) {
  //   GeneralWorkoutPageExerciseModel generatedModel = GeneralWorkoutPageExerciseModel(
  //     id: model.id,
  //     exerciseOrder: model.exerciseOrder,
  //     movementId: model.movementId,
  //     exerciseDuration: model.duration,
  //     numWorkingSets: model.numWorkingSets,
  //     workedMuscleGroups: model.workedMuscleGroups,
  //   );
  //   return generatedModel;
  // }

  SelectedWorkoutIntermittentExerciseModel copyWith({
    required SelectedWorkoutIntermittentExerciseModel currentModel,
    int? workoutId,
    int? exerciseOrder,
    String? movementName,
    int? movementId,
    String? exerciseDuration,
    int? numWorkingSets,
    MovementWorkedMuscleGroupsType? workedMuscleGroups,
    List<GeneralExerciseSetModel>? exerciseSets,
  }) {
    SelectedWorkoutIntermittentExerciseModel generatedState =
        SelectedWorkoutIntermittentExerciseModel(
      workoutId: workoutId ?? currentModel.workoutId,
      exerciseOrder: exerciseOrder ?? currentModel.exerciseOrder,
      movementName: movementName ?? currentModel.movementName,
      exerciseDuration: exerciseDuration ?? currentModel.exerciseDuration,
      numWorkingSets: numWorkingSets ?? currentModel.numWorkingSets,
      workedMuscleGroups: workedMuscleGroups ?? currentModel.workedMuscleGroups,
      exerciseSets: exerciseSets ?? currentModel.exerciseSets,
    );
    return generatedState;
  }

  int getWorkingSetsPerMuscleGroup(MuscleGroupType muscleGroup) {
    return workedMuscleGroups.getWorkingSetsPerMuscleGroup(
        muscleGroup, numWorkingSets);
  }
}

// should be the general shape for exercises as seen on the workout page
// used for loaded exercises?
class GeneralWorkoutPageExerciseModel {
  // db table fields
  final int? id;
  final int workoutId;
  final int? movementId;
  final int exerciseOrder;
  final String? exerciseDuration; // nullable as we're not enforcing recording
  final int numWorkingSets;

  final String movementName;
  final MovementWorkedMuscleGroupsType workedMuscleGroups;
  final List<GeneralExerciseSetModel> exerciseSets;

  GeneralWorkoutPageExerciseModel({
    this.id,
    required this.workoutId,
    required this.movementId,
    required this.exerciseOrder,
    this.exerciseDuration,
    required this.numWorkingSets,
    required this.workedMuscleGroups,
    required this.movementName,
    this.exerciseSets = const [],
  });

  factory GeneralWorkoutPageExerciseModel.fromSelectedWorkoutIntermittentExerciseModel(
      SelectedWorkoutIntermittentExerciseModel exercise) {
    GeneralWorkoutPageExerciseModel convertedModel =
        GeneralWorkoutPageExerciseModel(
            id: exercise.id,
            workoutId: exercise.workoutId,
            movementId: exercise.movementId,
            exerciseOrder: exercise.exerciseOrder,
            exerciseDuration: exercise.exerciseDuration,
            numWorkingSets: exercise.numWorkingSets,
            movementName: exercise.movementName!,
            workedMuscleGroups: exercise.workedMuscleGroups,
            exerciseSets: exercise.exerciseSets);

    return convertedModel;
  }

  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> modelAsMap = {
  //     'id': id,
  //     'exerciseOrder': exerciseOrder,
  //     'movementName': movementName,
  //     'movementId': movementId,
  //     'exerciseDuration': exerciseDuration,
  //     'numWorkingSets': numWorkingSets,
  //     'primaryMuscleGroup': workedMuscleGroups.returnPrimaryMuscleGroups().first.name,
  //     'exerciseSets':
  //     exerciseSets.map((exerciseSet) => exerciseSet.toMap()).toList()
  //   };
  //
  //   return modelAsMap;
  // }
  //
  // factory GeneralWorkoutPageExerciseModel.fromExerciseTableWithWorkedMuscleGroups(
  //     ExerciseTableWithWorkedMuscleGroups model) {
  //   GeneralWorkoutPageExerciseModel generatedModel = GeneralWorkoutPageExerciseModel(
  //     id: model.id,
  //     exerciseOrder: model.exerciseOrder,
  //     movementId: model.movementId,
  //     exerciseDuration: model.duration,
  //     numWorkingSets: model.numWorkingSets,
  //     workedMuscleGroups: model.workedMuscleGroups,
  //   );
  //   return generatedModel;
  // }

  GeneralWorkoutPageExerciseModel copyWith({
    required GeneralWorkoutPageExerciseModel currentModel,
    int? workoutId,
    int? exerciseOrder,
    String? movementName,
    int? movementId,
    String? exerciseDuration,
    int? numWorkingSets,
    MovementWorkedMuscleGroupsType? workedMuscleGroups,
    List<GeneralExerciseSetModel>? exerciseSets,
  }) {
    GeneralWorkoutPageExerciseModel generatedState =
        GeneralWorkoutPageExerciseModel(
      workoutId: workoutId ?? currentModel.workoutId,
      exerciseOrder: exerciseOrder ?? currentModel.exerciseOrder,
      movementName: movementName ?? currentModel.movementName,
      exerciseDuration: exerciseDuration ?? currentModel.exerciseDuration,
      numWorkingSets: numWorkingSets ?? currentModel.numWorkingSets,
      workedMuscleGroups: workedMuscleGroups ?? currentModel.workedMuscleGroups,
      exerciseSets: exerciseSets ?? currentModel.exerciseSets,
    );
    return generatedState;
  }

  int getWorkingSetsPerMuscleGroup(MuscleGroupType muscleGroup) {
    return workedMuscleGroups.getWorkingSetsPerMuscleGroup(
        muscleGroup, numWorkingSets);
  }
}

// class GeneralExerciseModel {
//   final int? id;
//   final int? exerciseOrder;
//   final String movementName;
//   final int? movementId;
//   final String? exerciseDuration;
//   final int? numWorkingSets;
//   final Map<MuscleGroupType, RoleType> workedMuscleGroups;
//
//   // final MuscleGroupType secondaryMuscleGroup;
//   final List<GeneralExerciseSetModel> exerciseSets;
//
//   GeneralExerciseModel(
//       {this.id,
//       this.exerciseOrder,
//       required this.movementName,
//       required this.movementId,
//       this.exerciseDuration,
//       this.numWorkingSets,
//       required this.workedMuscleGroups,
//       // required this.secondaryMuscleGroup,
//       required this.exerciseSets});
// }

// ===================================

class LoadedExerciseModel extends GeneralWorkoutPageExerciseModel {
  final int id;
  final int movementId;

  LoadedExerciseModel({
    required this.id,
    required super.workoutId,
    required super.exerciseOrder,
    required super.movementName,
    required this.movementId,
    super.exerciseDuration,
    required super.numWorkingSets,
    required super.workedMuscleGroups,
    required super.exerciseSets,
  });

// factory LoadedExerciseModel.fromMap(Map<String, dynamic> map) {
//   LoadedExerciseModel convertedExercise = LoadedExerciseModel(
//     id: map['id'],
//     exerciseOrder: map['exercise_order'],
//     movementName: map['movement_name'],
//     movementId: map['movement_id'],
//     exerciseDuration: map['exercise_duration'],
//     numWorkingSets: map['num_working_sets'],
//     workedMuscleGroups: {},
//     // secondaryMuscleGroup: secondaryMuscleGroup,
//     exerciseSets: [],
//   );
//   return convertedExercise;
// }

// GeneralExerciseModel transformToGeneralModel() {
//   GeneralExerciseModel convertedModel = GeneralExerciseModel(
//       id: id,
//       exerciseOrder: exerciseOrder,
//       movementName: movementName,
//       movementId: movementId,
//       exerciseDuration: exerciseDuration,
//       numWorkingSets: numWorkingSets,
//       workedMuscleGroups: workedMuscleGroups,
//       exerciseSets: exerciseSets
//           .map((exerciseSets) => exerciseSets.transformToGeneralModel())
//           .toList());
//
//   return convertedModel;
// }
}

class NewExerciseModel2 extends GeneralWorkoutPageExerciseModel {
  final int? movementId;

  NewExerciseModel2(
      {required super.workoutId,
        this.movementId,
      required super.exerciseOrder,
        super.exerciseDuration,
        required super.numWorkingSets,
        required super.workedMuscleGroups,
      required super.movementName,
      required super.exerciseSets});
}

// to be made redundant
// class NewExerciseModel {
//   final int? exerciseOrder;
//   final String movementName;
//   final int? movementId; // nullable as if movement is new, no id exists
//   final String?
//       exerciseDuration; // null as we don't know how long the exercise will take before end
//   final int? numWorkingSets; // could be init = 0 and incrementally increase..
//   final MovementWorkedMuscleGroupsType workedMuscleGroups;
//   final List<NewExerciseSetModel> exerciseSets;
//
//   NewExerciseModel(
//       {this.exerciseOrder,
//       required this.movementName,
//       this.movementId,
//       this.exerciseDuration,
//       this.numWorkingSets,
//       required this.workedMuscleGroups,
//       // required this.secondaryMuscleGroup,
//       required this.exerciseSets});
//
//   GeneralExerciseModel transformToGeneralModel() {
//     GeneralExerciseModel convertedModel = GeneralExerciseModel(
//         exerciseOrder: exerciseOrder,
//         movementName: movementName,
//         movementId: movementId,
//         numWorkingSets: numWorkingSets,
//         workedMuscleGroups: workedMuscleGroups,
//         exerciseSets: exerciseSets
//             .map((exerciseSets) => exerciseSets.transformToGeneralModel())
//             .toList());
//
//     return convertedModel;
//   }
//
//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> modelAsMap = {
//       'exerciseOrder': exerciseOrder,
//       'movementName': movementName,
//       'movementId': movementId,
//       'exerciseDuration': exerciseDuration,
//       'numWorkingSets': numWorkingSets,
//       'primaryMuscleGroup': workedMuscleGroups.toString().split(".").last,
//       'exerciseSets':
//           exerciseSets.map((exerciseSet) => exerciseSet.toMap()).toList()
//     };
//
//     return modelAsMap;
//   }
//
//   factory NewExerciseModel.fromJson(Map<String, dynamic> json) {
//     return NewExerciseModel(
//       exerciseOrder: json['exerciseOrder'],
//       movementName: json['movementName'],
//       movementId: json['movementId'],
//       exerciseDuration: json['exerciseDuration'],
//       numWorkingSets: json['numWorkingSets'],
//       workedMuscleGroups: {},
//       exerciseSets: (json['exerciseSets'] as List)
//           .map((setJson) => NewExerciseSetModel.fromJson(setJson))
//           .toList(),
//     );
//   }
// }
