class GeneralExerciseSetModel {
  final int? id;
  final int exerciseSetOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? setDuration;
  final String? notes;

  GeneralExerciseSetModel(
      {this.id,
      required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      this.extraReps,
      this.setDuration,
      this.notes});
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
