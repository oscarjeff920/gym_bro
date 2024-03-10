import 'package:equatable/equatable.dart';

class InitExerciseSetModelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExerciseSetModelState extends InitExerciseSetModelState {
  final int? id;
  final int exerciseSetOrder;
  final bool isWarmUp;
  final double weight;
  final int reps;
  final int? extraReps;
  final String? repDuration;
  final String? notes;

  ExerciseSetModelState(
      {this.id,
      required this.exerciseSetOrder,
      required this.isWarmUp,
      required this.weight,
      required this.reps,
      this.extraReps,
      this.repDuration,
      this.notes});

  @override
  List<Object?> get props =>
      [exerciseSetOrder, isWarmUp, weight, extraReps, repDuration, notes];
}

class NewExerciseSetModelState extends ExerciseSetModelState {
  NewExerciseSetModelState(
      {required super.exerciseSetOrder,
      required super.isWarmUp,
      required super.weight,
      required super.reps,
      super.extraReps,
      super.repDuration,
      super.notes});
}

class LoadedExerciseSetModelState extends ExerciseSetModelState {
  LoadedExerciseSetModelState(
      {required super.id,
      required super.exerciseSetOrder,
      required super.isWarmUp,
      required super.weight,
      required super.reps,
      super.extraReps,
      super.repDuration,
      super.notes});
}
