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
  final int weight;
  final int reps;
  final bool isWarmUp;
  final String? notes;

  const Sets({
    this.id,
    required this.weight,
    required this.reps,
    required this.isWarmUp,
    this.notes,
  });
}

class CurrentSet {
  final int? id;
  final int? weight;
  final int? reps;
  final bool? isWarmUp;
  final String? notes;

  const CurrentSet({
    this.id,
    this.weight,
    this.reps,
    this.isWarmUp,
    this.notes,
  });
}