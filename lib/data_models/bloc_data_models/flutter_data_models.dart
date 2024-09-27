import '../../constants/enums.dart';

class Workout {
  final int? id;
  final DateTime date;
  final DateTime duration;
  final Map<MuscleGroupType, int> groupSets;

  const Workout(
      {this.id,
      required this.date,
      required this.duration,
      required this.groupSets});
}

class CurrentSet {
  final int? id;
  final bool? isWarmUp;
  final double? weight;
  final int? reps;
  final int? extraReps;
  final Duration? setDuration;
  final String? notes;

  const CurrentSet({
    this.id,
    this.isWarmUp,
    this.weight,
    this.reps,
    this.extraReps,
    this.setDuration,
    this.notes,
  });
}
