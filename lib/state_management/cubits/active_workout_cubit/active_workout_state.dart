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

  ActiveWorkoutOnState({
    required this.day,
    required this.month,
    required this.year,
    this.workoutStartTime,
    this.workoutDuration,
  });

  @override
  List<Object?> get props =>
      [day, month, year, workoutStartTime, workoutDuration];
}

class NewActiveWorkoutState extends ActiveWorkoutOnState {
  final List<NewExerciseModel2> exercises;

  NewActiveWorkoutState(
      {required super.day,
      required super.month,
      required super.year,
      super.workoutStartTime,
      super.workoutDuration,
      required this.exercises});

  factory NewActiveWorkoutState.copyWith(
      {required NewActiveWorkoutState currentState,
      String? workoutDuration,
      List<NewExerciseModel2>? newExercises}) {
    List<NewExerciseModel2> savedExercises = [];
    for (var exercise in currentState.exercises) {
      savedExercises.add(exercise);
    }
    if (newExercises != null) {
      for (var exercise in newExercises) {
        savedExercises.add(exercise);
      }
    }
    return NewActiveWorkoutState(
        day: currentState.day,
        month: currentState.month,
        year: currentState.year,
        workoutStartTime: currentState.workoutStartTime,
        workoutDuration: workoutDuration ?? currentState.workoutDuration,
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

// this state is emitted while the exercise names and sets are fetched
// between the home and workout page
class LoadingActiveWorkoutState extends ActiveWorkoutOnState {
  final int id;
  final List<SelectedWorkoutIntermittentExerciseModel> exercises;

  LoadingActiveWorkoutState(
      {required this.id,
      required super.day,
      required super.month,
      required super.year,
      required super.workoutStartTime,
      required super.workoutDuration,
      required this.exercises});

  LoadingActiveWorkoutState copyWith(
      {int? newId,
      int? newDay,
      int? newMonth,
      int? newYear,
      String? newWorkoutStartTime,
      String? newWorkoutDuration,
      List<SelectedWorkoutIntermittentExerciseModel>? loadedExercises}) {
    return LoadingActiveWorkoutState(
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

class LoadedActiveWorkoutState extends ActiveWorkoutOnState {
  final int id;
  final List<GeneralWorkoutPageExerciseModel> exercises;

  LoadedActiveWorkoutState(
      {required this.id,
      required super.day,
      required super.month,
      required super.year,
      required super.workoutStartTime,
      required super.workoutDuration,
      required this.exercises});

  LoadedActiveWorkoutState copyWith(
      {int? newId,
      int? newDay,
      int? newMonth,
      int? newYear,
      String? newWorkoutStartTime,
      String? newWorkoutDuration,
      List<GeneralWorkoutPageExerciseModel>? loadedExercises}) {
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
