// Model to track 1-to-1 to database table

class ExerciseSetTable {
  final int id;
  final int exerciseId;
  final int setOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? duration;
  final String? notes;

  ExerciseSetTable(
      {required this.id,
      required this.exerciseId,
      required this.setOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      this.extraReps,
      this.duration,
      this.notes});

  Duration stringToDuration(String stringDuration) {
    // TODO: work this one out punk
    return const Duration();
  }

  factory ExerciseSetTable.fromMap(Map<String, dynamic> map) {
    return ExerciseSetTable(
      id: map['id'],
      exerciseId: map['exercise_id'],
      setOrder: map['set_order'],
      isWarmUp: map['is_warm_up'] == 1 ? true : false,
      weight: map['weight'].toDouble(),
      reps: map['reps'],
      extraReps: map['extra_reps'],
      duration: map['duration'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exercise_id': exerciseId,
      'set_order': setOrder,
      'is_warm_up': isWarmUp ? 1 : 0,
      'weight': weight,
      'reps': reps,
      'extra_reps': extraReps,
      'duration': duration,
      'notes': notes,
    };
  }
}
