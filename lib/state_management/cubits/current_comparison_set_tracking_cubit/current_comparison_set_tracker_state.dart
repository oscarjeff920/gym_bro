import 'package:equatable/equatable.dart';

class CurrentComparisonSetTrackerState extends Equatable {
  final int currentPreviousExerciseIndex;
  final int maxIndexOfPreviousExerciseSessions;
  final int currentPRExerciseIndex;
  final int maxIndexOfPRExerciseSessions;

  const CurrentComparisonSetTrackerState(
      {required this.currentPreviousExerciseIndex,
      required this.maxIndexOfPreviousExerciseSessions,
      required this.currentPRExerciseIndex,
      required this.maxIndexOfPRExerciseSessions});

  @override
  get props => [
        currentPreviousExerciseIndex,
        maxIndexOfPreviousExerciseSessions,
        currentPRExerciseIndex,
        maxIndexOfPRExerciseSessions
      ];

  copyWith(
      {int? updatedPreviousExerciseIndex,
      int? updatedMaxIndexPreviousSets,
      int? updatedPRIndex,
      int? updatedMaxIndexPR}) {
    CurrentComparisonSetTrackerState copiedState =
        CurrentComparisonSetTrackerState(
            currentPreviousExerciseIndex: updatedPreviousExerciseIndex ??
                currentPreviousExerciseIndex,
            maxIndexOfPreviousExerciseSessions: updatedMaxIndexPreviousSets ??
                maxIndexOfPreviousExerciseSessions,
            currentPRExerciseIndex: updatedPRIndex ?? currentPRExerciseIndex,
            maxIndexOfPRExerciseSessions:
                updatedMaxIndexPR ?? maxIndexOfPRExerciseSessions);

    return copiedState;
  }
}
