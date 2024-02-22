// ignore: camel_case_types
class ExerciseSetModel_ExerciseModal {
  final int? id;
  final int weight;
  final int reps;
  final int extraReps;
  final Duration setDurations;
  final String notes;

  ExerciseSetModel_ExerciseModal(
      {required this.id,
      required this.weight,
      required this.reps,
      required this.extraReps,
      required this.setDurations,
      required this.notes});
}
