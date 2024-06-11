import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';

class GetLastExerciseSetsByMovementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLastExerciseSetNotQueriedState
    extends GetLastExerciseSetsByMovementState {}

class GetLastExerciseSetQueryingState
    extends GetLastExerciseSetsByMovementState {}

class SuccessfulGetLastExerciseSetsByMovementQueryState
    extends GetLastExerciseSetsByMovementState {
  final List<Sets> lastExerciseSets;

  provideMatchingPreviousSet(
      CurrentSet currentSet, List<Sets> completedSets) {
    int totalCompletedSets = completedSets.length;

    List<Sets> lastTimeWorkingSets = [];

    completedSets.asMap().forEach((index, value) {
      if (!value.isWarmUp) lastTimeWorkingSets.add(value);
    });

    int totalSetsLastTime = lastExerciseSets.length;
    int totalWorkingSetsLastTime = lastTimeWorkingSets.length;
    int totalWarmupSetsLastTime = totalSetsLastTime - totalWorkingSetsLastTime;
    Sets comparisonSet = lastExerciseSets[totalCompletedSets];

    // if the user does more sets than last time, no comparison can be made
    // this is also the case if user wants to do more warm up sets than last time
    if (
    totalCompletedSets >= totalSetsLastTime ||
        currentSet.isWarmUp == true && !comparisonSet.isWarmUp
    ) {
      return const CurrentSet();
    }

    // if (comparisonSet.isWarmUp && currentSet.isWarmUp == false) {
    //   lastTimeWorkingSets
    // }
    // if (comparisonSet.isWarmUp == currentSet.isWarmUp)
    return comparisonSet;
  }

  SuccessfulGetLastExerciseSetsByMovementQueryState(
      {required this.lastExerciseSets});

  @override
  List<Object?> get props => [lastExerciseSets];
}

class GetLastExerciseSetsQueryErrorState
    extends GetLastExerciseSetsByMovementState {
  final Object error;

  GetLastExerciseSetsQueryErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
