import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';

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
    return {
      'year': year,
      'month': month,
      'day': day,
      'workout_start_time': workoutStartTime,
      'duration': duration
    };
  }
}

class WorkoutTableWithExercises extends WorkoutTable {
  final List<ExerciseTable> exercises;

  WorkoutTableWithExercises(
      {required super.id,
      required super.year,
      required super.month,
      required super.day,
      required super.workoutStartTime,
      required super.duration,
      required this.exercises});
}

class WorkoutTableWithExercisesWorkedMuscleGroups extends WorkoutTable {
  final List<ExerciseTableWithWorkedMuscleGroups> exercises;

  WorkoutTableWithExercisesWorkedMuscleGroups(
      {required super.id,
        required super.year,
        required super.month,
        required super.day,
        required super.workoutStartTime,
        required super.duration,
        required this.exercises});


  int getNumWorkingSetsPerMuscleInWorkout(MuscleGroupType muscleGroup) {
    int totalSets = 0;
    for (ExerciseTableWithWorkedMuscleGroups exercise in exercises) {
      totalSets += exercise.getWorkingSetsPerMuscleGroup(muscleGroup);
    }
    return totalSets;
  }

}

