import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';

class ExerciseModelState extends Equatable {
  final int? id;
  final int exerciseOrder;
  final int movementId;
  final String movementName;
  final String exerciseDuration;
  final int totalWorkingSets;
  final MuscleGroupType primaryMuscleGroup;
  final MuscleGroupType secondaryMuscleGroup;
  final List<GeneralExerciseSetModel> exerciseSets;

  ExerciseModelState(
      {this.id,
      required this.exerciseOrder,
      required this.movementId,
      required this.movementName,
      required this.exerciseDuration,
      required this.totalWorkingSets,
      required this.primaryMuscleGroup,
      required this.secondaryMuscleGroup,
      required this.exerciseSets});

  @override
  List<Object> get props => [
        exerciseOrder,
        movementId,
        movementName,
        exerciseDuration,
        totalWorkingSets,
        primaryMuscleGroup,
        secondaryMuscleGroup,
        exerciseSets
      ];
}

class NewExerciseModelState extends ExerciseModelState {
  NewExerciseModelState(
      {required super.exerciseOrder,
      required super.movementId,
      required super.movementName,
      required super.exerciseDuration,
      required super.totalWorkingSets,
      required super.primaryMuscleGroup,
      required super.secondaryMuscleGroup,
      required super.exerciseSets});
}

class LoadedExerciseModelState extends ExerciseModelState {
  LoadedExerciseModelState(
      {required super.id,
      required super.exerciseOrder,
      required super.movementId,
      required super.movementName,
      required super.exerciseDuration,
      required super.totalWorkingSets,
      required super.primaryMuscleGroup,
      required super.secondaryMuscleGroup,
      required super.exerciseSets});
}
