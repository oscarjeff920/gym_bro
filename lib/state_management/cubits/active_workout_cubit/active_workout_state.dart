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

  ActiveWorkoutOnState(
      {required this.day, required this.month, required this.year});

  @override
  List<Object?> get props => [day, month, year];
}

class NewActiveWorkoutState extends ActiveWorkoutOnState {
  final String? workoutDuration;
  final List<NewExerciseModel> exercises;

  NewActiveWorkoutState({
    required super.day,
    required super.month,
    required super.year,
    this.workoutDuration,
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
  final String workoutDuration;
  final List<LoadedExerciseModel> exercises;

  LoadedActiveWorkoutState({
    required this.id,
    required super.day,
    required super.month,
    required super.year,
    required this.workoutDuration,
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

//============================================

// class ActiveWorkoutState1 extends Equatable {
//   final int? day;
//   final int? month;
//   final int? year;
//   final String? workoutDuration;
//   final List<GeneralExerciseModel> exercises;
//
//   const ActiveWorkoutState1(
//       {this.day, this.month, this.year, this.workoutDuration, required this.exercises});
//
//   @override
//   List<Object?> get props => [day, month, year, workoutDuration, exercises];
// }
//
// class WorkoutOnState1 extends ActiveWorkoutState1 {
//   const WorkoutOnState1({required int day,
//     required int month,
//     required int year,
//     required String workoutDuration, required super.exercises})
//       : super(
//       day: day,
//       month: month,
//       year: year,
//       workoutDuration: workoutDuration);
// }
//
// class LoadedWorkoutState1 extends WorkoutOnState1 {
//   final int id;
//
//   // final List<LoadedExerciseModel> loadedExercises;
//
//   LoadedWorkoutState1(
//       {required this.id, required super.day, required super.month, required super.year, required super.workoutDuration, required List<
//           LoadedExerciseModel> super.exercises}) : super(exercises: exercises)
// }

// class NewWorkoutState1 extends WorkoutOnState1 {
//
//   // const NewWorkoutState(
//   //     {required List<NewExerciseModel> exercises}) : super();
// }
