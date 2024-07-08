import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';

class ActiveWorkoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActiveWorkoutOnState extends ActiveWorkoutState {
  final int day;
  final int month;
  final int year;
  final String? workoutStartTime;
  final String? workoutDuration;
  final List<WorkoutPageExerciseModel> exercises;

  ActiveWorkoutOnState(
      {required this.day,
      required this.month,
      required this.year,
      this.workoutStartTime,
      this.workoutDuration,
      this.exercises = const []});

  @override
  List<Object?> get props =>
      [day, month, year, workoutStartTime, workoutDuration];
}

class NewActiveWorkoutState extends ActiveWorkoutOnState {
  // final List<NewExerciseModel> exercises;

  NewActiveWorkoutState(
      {required super.day,
      required super.month,
      required super.year,
      super.workoutStartTime,
      super.workoutDuration,
      super.exercises});

  NewActiveWorkoutState copyWith(
      {String? workoutDuration, List<WorkoutPageExerciseModel>? newExercises}) {
    List<WorkoutPageExerciseModel> savedExercises = [];
    for (var exercise in exercises) {
      savedExercises.add(exercise);
    }
    if (newExercises != null) {
      for (var exercise in newExercises) {
        savedExercises.add(exercise);
      }
    }
    return NewActiveWorkoutState(
        day: day,
        month: month,
        year: year,
        workoutStartTime: workoutStartTime,
        workoutDuration: workoutDuration ?? this.workoutDuration,
        exercises: savedExercises);
  }

  newWorkoutToMap() {
    Map<String, dynamic> modelAsMap = {
      'day': day,
      'month': month,
      'year': year,
      'workoutStartTime': workoutStartTime,
      'workoutDuration': workoutDuration,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList()
    };

    return modelAsMap;
  }

  @override
  List<Object?> get props => [...super.props, workoutDuration, exercises];
}

class LoadedActiveWorkoutState extends ActiveWorkoutOnState {
  final int id;
  // final List<WorkoutPageExerciseModel> exercises;

  LoadedActiveWorkoutState(
      {required this.id,
      required super.day,
      required super.month,
      required super.year,
      required super.workoutStartTime,
      required super.workoutDuration,
      required super.exercises});

  LoadedActiveWorkoutState copyWith(
      {int? newId,
      int? newDay,
      int? newMonth,
      int? newYear,
      String? newWorkoutStartTime,
      String? newWorkoutDuration,
      List<WorkoutPageExerciseModel>? loadedExercises}) {
    return LoadedActiveWorkoutState(
        id: newId ?? id,
        day: newDay ?? day,
        month: newMonth ?? month,
        year: newYear ?? year,
        workoutStartTime: newWorkoutStartTime ?? workoutStartTime,
        workoutDuration: newWorkoutDuration ?? workoutDuration,
        exercises: loadedExercises ?? exercises);
  }

  @override
  List<Object?> get props => [id, ...super.props, workoutDuration, exercises];
}
