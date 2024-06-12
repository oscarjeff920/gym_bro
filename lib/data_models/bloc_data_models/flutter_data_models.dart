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

class Sets {
  final int? id;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final Duration? setDuration;
  final String? notes;

  const Sets({
    this.id,
    required this.isWarmUp,
    required this.weight,
    required this.reps,
    this.extraReps,
    this.setDuration,
    this.notes,
  });

  factory Sets.fromMap(Map map) {
    return Sets(
        id: map['id'],
        isWarmUp: map['is_warm_up'] == 1 ? true : false,
        weight: map['weight'].toDouble(),
        reps: map['reps'],
        extraReps: map['extra_reps'],
        // TODO: Change this shit. Duration <=> String
        setDuration: null,
        notes: map['notes'] ?? "");
  }
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
