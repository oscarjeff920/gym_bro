class Workout {
  final int id;
  final DateTime date;
  final DateTime duration;

  const Workout({
    required this.id,
    required this.date,
    required this.duration,
  });
}

class Sets {
  final int id;
  final int weight;
  final int reps;
  final bool isWarmUp;
  final String? notes;

  const Sets({
    required this.id,
    required this.weight,
    required this.reps,
    required this.isWarmUp,
    this.notes,
  });
}