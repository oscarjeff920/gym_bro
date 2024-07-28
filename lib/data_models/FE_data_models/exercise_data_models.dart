import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';
import 'exercise_set_data_models.dart';

// should be the general shape for exercises as seen on the workout page
// used for loaded exercises?
class GeneralWorkoutPageExerciseModel {
  // db table fields
  final int? id;
  final int? workoutId;
  final int? movementId;
  final int exerciseOrder;
  final String? exerciseDuration; // nullable as we're not enforcing recording
  final int numWorkingSets;

  final String movementName;
  final MovementWorkedMuscleGroupsType workedMuscleGroups;
  final List<GeneralExerciseSetModel> exerciseSets;

  GeneralWorkoutPageExerciseModel({
    this.id,
    this.workoutId,
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
            movementName: exercise.movementName,
            workedMuscleGroups: exercise.workedMuscleGroups,
            exerciseSets: exercise.exerciseSets);

    return convertedModel;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> modelAsMap = {
      'id': id,
      'workoutId': workoutId,
      'movementId': movementId,
      'exerciseOrder': exerciseOrder,
      'exerciseDuration': exerciseDuration,
      'numWorkingSets': numWorkingSets,
      'workedMuscleGroups': workedMuscleGroups.toMap(),
      'movementName': movementName,
      'exerciseSets':
          exerciseSets.map((exerciseSet) => exerciseSet.toMap()).toList()
    };

    return modelAsMap;
  }

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
      movementId: movementId ?? currentModel.movementId,
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

// This model is used to convert between a homepage exercise model
// to GeneralWorkoutPageExerciseModel
class SelectedWorkoutIntermittentExerciseModel
    extends GeneralWorkoutPageExerciseModel {
  SelectedWorkoutIntermittentExerciseModel({
    required int id,
    required int workoutId,
    required int movementId,
    required exerciseOrder,
    exerciseDuration,
    required numWorkingSets,
    required workedMuscleGroups,

    // additional parameters
    String? movementName,
    List<GeneralExerciseSetModel> exerciseSets = const [],
  }) : super(
            id: id,
            workoutId: workoutId,
            movementId: movementId,
            exerciseOrder: exerciseOrder,
            exerciseDuration: exerciseDuration,
            numWorkingSets: numWorkingSets,
            workedMuscleGroups: workedMuscleGroups,
            movementName: movementName ?? '',
            exerciseSets: exerciseSets);

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

  factory SelectedWorkoutIntermittentExerciseModel.copyWith({
    required SelectedWorkoutIntermittentExerciseModel currentModel,
    int? id,
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
      id: id ?? currentModel.id!,
      workoutId: workoutId ?? currentModel.workoutId!,
      movementId: movementId ?? currentModel.movementId!,
      exerciseOrder: exerciseOrder ?? currentModel.exerciseOrder,
      movementName: movementName ?? currentModel.movementName,
      exerciseDuration: exerciseDuration ?? currentModel.exerciseDuration,
      numWorkingSets: numWorkingSets ?? currentModel.numWorkingSets,
      workedMuscleGroups: workedMuscleGroups ?? currentModel.workedMuscleGroups,
      exerciseSets: exerciseSets ?? currentModel.exerciseSets,
    );
    return generatedState;
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
  LoadedExerciseModel({
    required int id,
    required int workoutId,
    required int exerciseOrder,
    required String movementName,
    required int movementId,
    exerciseDuration,
    required numWorkingSets,
    required workedMuscleGroups,
    required exerciseSets,
  }) : super(
            id: id,
            workoutId: workoutId,
            movementId: movementId,
            exerciseOrder: exerciseOrder,
            movementName: movementName,
            exerciseDuration: exerciseDuration,
            numWorkingSets: numWorkingSets,
            workedMuscleGroups: workedMuscleGroups,
            exerciseSets: exerciseSets);

  factory LoadedExerciseModel.fromDbQueryMap(Map<String, dynamic> map) {
    LoadedExerciseModel convertedExercise = LoadedExerciseModel(
      id: map['id'],
      workoutId: map['workout_id'],
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
  NewExerciseModel2(
      {movementId,
      required exerciseOrder,
      exerciseDuration,
      required numWorkingSets,
      required workedMuscleGroups,
      required movementName,
      required exerciseSets})
      : super(
            movementId: movementId,
            exerciseOrder: exerciseOrder,
            exerciseDuration: exerciseDuration,
            numWorkingSets: numWorkingSets,
            workedMuscleGroups: workedMuscleGroups,
            movementName: movementName,
            exerciseSets: exerciseSets);

  factory NewExerciseModel2.copyWith(
      {required NewExerciseModel2 currentModel,
      int? movementId,
      int? exerciseOrder,
      String? exerciseDuration,
      int? numWorkingSets,
      String? movementName,
      MovementWorkedMuscleGroupsType? workedMuscleGroups,
      List<GeneralExerciseSetModel>? exerciseSets}) {
    NewExerciseModel2 generatedModel = NewExerciseModel2(
        movementId: movementId ?? currentModel.movementId,
        exerciseOrder: exerciseOrder ?? currentModel.exerciseOrder,
        exerciseDuration: exerciseDuration ?? currentModel.exerciseDuration,
        numWorkingSets: numWorkingSets ?? currentModel.numWorkingSets,
        workedMuscleGroups:
            workedMuscleGroups ?? currentModel.workedMuscleGroups,
        movementName: movementName ?? currentModel.movementName,
        exerciseSets: exerciseSets ?? currentModel.exerciseSets);

    return generatedModel;
  }

  factory NewExerciseModel2.fromMap({required Map<String, dynamic> map}) {
    NewExerciseModel2 regeneratedModel = NewExerciseModel2(
      movementId: map['movementId'],
        exerciseOrder: map['exerciseOrder'],
        numWorkingSets: map['numWorkingSets'],
        workedMuscleGroups: MovementWorkedMuscleGroupsType.fromMap(map: map['workedMuscleGroups']),
        movementName: map['movementName'],
        exerciseSets: map['exerciseSets'].map<GeneralExerciseSetModel>((exerciseSetMap) {
          return GeneralExerciseSetModel.fromMap(map: exerciseSetMap);
        }).toList()
    );

    return regeneratedModel;
  }
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
