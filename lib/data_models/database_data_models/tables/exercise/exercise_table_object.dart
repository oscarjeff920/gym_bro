class ExerciseTable {
  final int? id;
  final int movementId;
  final int workoutId;
  final int exerciseOrder;
  final Duration? duration;
  final int numbWorkingSets;

  ExerciseTable(
      {this.id,
      required this.movementId,
      required this.workoutId,
      required this.exerciseOrder,
      this.duration,
      required this.numbWorkingSets});

  factory ExerciseTable.fromMap(Map<String, dynamic> map) {
    return ExerciseTable(
      id: map['id'],
      movementId: map['movement_id'],
      workoutId: map['workout_id'],
      exerciseOrder: map['exercise_order'],
      duration: map['duration'],
      numbWorkingSets: map['numb_working_sets'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movement_id': movementId,
      'workout_id': workoutId,
      'exercise_order': exerciseOrder,
      'duration': duration.toString(),
      'numb_working_sets': numbWorkingSets,
    };
  }
}
