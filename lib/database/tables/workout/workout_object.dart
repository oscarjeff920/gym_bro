class Workout {
  final int? id;
  final DateTime date;
  final Duration duration;

  Workout({this.id, required this.date, required this.duration});

  DateTime stringToDate(String dateString) {
    // TODO: make this work
    return DateTime.now();
  }

  Duration stringToDuration(String durationString) {
    // TODO: make this work
    return Duration();
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      date: map['date'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'date': date.toString(), 'duration': duration.toString()};
  }
}
