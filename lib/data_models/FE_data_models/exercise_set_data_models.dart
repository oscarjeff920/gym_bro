class GeneralExerciseSetModel {
  final int? id;
  final int exerciseSetOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? repDuration;
  final String? notes;

  GeneralExerciseSetModel(
      {this.id,
      required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      this.extraReps,
      this.repDuration,
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
  final String? repDuration;
  final String? notes;

  LoadedExerciseSetModel(
      {required this.id,
      required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      required this.extraReps,
      required this.repDuration,
      required this.notes});
}

class NewExerciseSetModel {
  final int exerciseSetOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? repDuration;
  final String? notes;

  NewExerciseSetModel(
      {required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      required this.extraReps,
      required this.repDuration,
      required this.notes});
}