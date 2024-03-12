import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';

class ActiveWorkoutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ActiveWorkoutOnState extends ActiveWorkoutState {
  final int day;
  final int month;
  final int year;
  final String? workoutDuration;

  ActiveWorkoutOnState(
      {required this.day, required this.month, required this.year, this.workoutDuration});

  @override
  List<Object?> get props => [day, month, year];
}

class NewActiveWorkoutState extends ActiveWorkoutOnState {
  final List<NewExerciseModel> exercises;

  NewActiveWorkoutState({
    required super.day,
    required super.month,
    required super.year,
    super.workoutDuration,
    required this.exercises
  });

  NewActiveWorkoutState copyWith({
    String? workoutDuration,
    List<NewExerciseModel>? newExercises
  }) {
    List<NewExerciseModel> savedExercises = [];
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
        workoutDuration: workoutDuration ?? this.workoutDuration,
        exercises: savedExercises
    );
  }

  @override
  List<Object?> get props => [...super.props, workoutDuration, exercises];
}

class LoadedActiveWorkoutState extends ActiveWorkoutOnState {
  final int id;
  final List<LoadedExerciseModel> exercises;

  LoadedActiveWorkoutState({
    required this.id,
    required super.day,
    required super.month,
    required super.year,
    required super.workoutDuration,
    required this.exercises
  });

  LoadedActiveWorkoutState copyWith({
    List<LoadedExerciseModel>? loadedExercises
  }) {
    return LoadedActiveWorkoutState(
        id: id,
        day: day,
        month: month,
        year: year,
        workoutDuration: workoutDuration,
        exercises: loadedExercises ?? exercises
    );
  }

  @override
  List<Object?> get props => [id, ...super.props, workoutDuration, exercises];
}
