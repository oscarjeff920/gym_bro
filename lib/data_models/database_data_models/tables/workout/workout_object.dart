class WorkoutTable {
  final int? id;
  final int year;
  final int month;
  final int day;
  final String? duration;

  WorkoutTable(
      {required this.id,
      required this.year,
      required this.month,
      required this.day,
      required this.duration});



  factory WorkoutTable.fromMap(Map<String, dynamic> map) {
    return WorkoutTable(
      id: map['id'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'day': day,
      'duration': duration
    };
  }
}
