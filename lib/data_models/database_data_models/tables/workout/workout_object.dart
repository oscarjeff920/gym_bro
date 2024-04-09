class WorkoutTable {
  final int? id;
  final int year;
  final int month;
  final int day;
  final String? workoutStartTime;
  final String? duration;

  WorkoutTable(
      {required this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.workoutStartTime,
      required this.duration});

  factory WorkoutTable.fromMap(Map<String, dynamic> map) {
    return WorkoutTable(
      id: map['id'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      workoutStartTime: map['start_time'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'year': year, 'month': month, 'day': day, 'workout_start_time': workoutStartTime, 'duration': duration};
  }
}
