class Workout {
  final int? id;
  final DateTime date;
  final DateTime duration;

  const Workout({
    this.id,
    required this.date,
    required this.duration,
  });
}

class Sets {
  final int? id;
  final bool isWarmUp;
  final int weight;
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
}

class CurrentSet {
  final int? id;
  final bool? isWarmUp;
  final int? weight;
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