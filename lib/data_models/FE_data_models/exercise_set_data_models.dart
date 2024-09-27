import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';

class GeneralExerciseSetModel {
  final int? id;
  final int? exerciseId;
  final int exerciseSetOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? setDuration;
  final String? notes;

  GeneralExerciseSetModel(
      {this.id,
      this.exerciseId,
      required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      this.extraReps,
      this.setDuration,
      this.notes});

  factory GeneralExerciseSetModel.fromExerciseSetTable(
      ExerciseSetTable exerciseSet) {
    GeneralExerciseSetModel convertedModel = GeneralExerciseSetModel(
        id: exerciseSet.id,
        exerciseId: exerciseSet.exerciseId,
        exerciseSetOrder: exerciseSet.setOrder,
        isWarmUp: exerciseSet.isWarmUp,
        weight: exerciseSet.weight,
        reps: exerciseSet.reps,
        extraReps: exerciseSet.extraReps,
        setDuration: exerciseSet.duration,
        notes: exerciseSet.notes);

    return convertedModel;
  }

  factory GeneralExerciseSetModel.fromMap({required Map<String, dynamic> map}) {
    GeneralExerciseSetModel regeneratedModel = GeneralExerciseSetModel(
        id: map['id'],
        exerciseId: map['exerciseId'],
        exerciseSetOrder: map['exerciseSetOrder'],
        isWarmUp: map['isWarmUp'],
        weight: map['weight'],
        reps: map['reps'],
        extraReps: map['extraReps'],
        setDuration: map['setDuration'],
        notes: map['notes']);

    return regeneratedModel;
  }

  factory GeneralExerciseSetModel.fromDbMap(
      {required Map<String, dynamic> map}) {
    GeneralExerciseSetModel regeneratedModel = GeneralExerciseSetModel(
        id: map['id'],
        exerciseId: map['exercise_id'],
        exerciseSetOrder: map['set_order'],
        isWarmUp: map['is_warm_up'] == 1 ? true : false,
        weight: map['weight'].toDouble(),
        reps: map['reps'],
        extraReps: map['extra_reps'],
        setDuration: map['duration'],
        notes: map['notes']);

    return regeneratedModel;
  }

  factory GeneralExerciseSetModel.fromSetsObject(
      {required GeneralExerciseSetModel exerciseSet, required int setOrder}) {
    GeneralExerciseSetModel convertedModel = GeneralExerciseSetModel(
        id: null,
        exerciseId: null,
        exerciseSetOrder: setOrder,
        isWarmUp: exerciseSet.isWarmUp,
        weight: exerciseSet.weight,
        reps: exerciseSet.reps,
        extraReps: exerciseSet.extraReps,
        setDuration: exerciseSet.setDuration.toString(),
        notes: exerciseSet.notes);

    return convertedModel;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> modelAsMap = {
      'id': id,
      'exerciseId': exerciseId,
      'exerciseSetOrder': exerciseSetOrder,
      'isWarmUp': isWarmUp,
      'weight': weight,
      'reps': reps,
      'extraReps': extraReps,
      'setDuration': setDuration,
      'notes': notes
    };

    return modelAsMap;
  }
}

// ===================================

class LoadedExerciseSetModel {
  final int id;
  final int exerciseSetOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? setDuration;
  final String? notes;

  LoadedExerciseSetModel(
      {required this.id,
      required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      required this.extraReps,
      required this.setDuration,
      required this.notes});

  factory LoadedExerciseSetModel.fromMap(Map<String, dynamic> map) {
    return LoadedExerciseSetModel(
        id: map['id'],
        exerciseSetOrder: map['set_order'],
        isWarmUp: map['is_warm_up'],
        weight: map['weight'],
        reps: map['reps'],
        extraReps: map['extra_reps'],
        setDuration: map['duration'],
        notes: map['notes']);
  }

  GeneralExerciseSetModel transformToGeneralModel() {
    GeneralExerciseSetModel convertedModel = GeneralExerciseSetModel(
        id: id,
        exerciseSetOrder: exerciseSetOrder,
        isWarmUp: isWarmUp,
        weight: weight,
        reps: reps,
        extraReps: extraReps,
        setDuration: setDuration,
        notes: notes);

    return convertedModel;
  }
}

class NewExerciseSetModel {
  final int exerciseSetOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? setDuration;
  final String? notes;

  NewExerciseSetModel(
      {required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      required this.extraReps,
      required this.setDuration,
      required this.notes});

  GeneralExerciseSetModel transformToGeneralModel() {
    GeneralExerciseSetModel convertedModel = GeneralExerciseSetModel(
        exerciseSetOrder: exerciseSetOrder,
        isWarmUp: isWarmUp,
        weight: weight,
        reps: reps,
        extraReps: extraReps,
        setDuration: setDuration,
        notes: notes);

    return convertedModel;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> modelAsMap = {
      'exerciseSetOrder': exerciseSetOrder,
      'isWarmUp': isWarmUp,
      'weight': weight,
      'reps': reps,
      'extraReps': extraReps,
      'setDuration': setDuration,
      'notes': notes,
    };

    return modelAsMap;
  }

  factory NewExerciseSetModel.fromJson(Map<String, dynamic> json) {
    return NewExerciseSetModel(
      exerciseSetOrder: json['exerciseSetOrder'],
      isWarmUp: json['isWarmUp'],
      weight: json['weight'],
      reps: json['reps'],
      extraReps: json['extraReps'],
      setDuration: json['setDuration'],
      notes: json['notes'],
    );
  }
}
