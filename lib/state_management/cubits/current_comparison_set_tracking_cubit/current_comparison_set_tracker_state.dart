import 'package:equatable/equatable.dart';

class CurrentComparisonSetTrackerState extends Equatable {
  final int currentPreviousExerciseIndex;
  final int currentPRExerciseIndex;

  const CurrentComparisonSetTrackerState(
      {required this.currentPreviousExerciseIndex,
      required this.currentPRExerciseIndex});

  @override
  get props => [currentPreviousExerciseIndex, currentPRExerciseIndex];

  copyWith({int? updatedPreviousExerciseIndex, int? updatedPRIndex}) {
    CurrentComparisonSetTrackerState copiedState = CurrentComparisonSetTrackerState(
        currentPreviousExerciseIndex: updatedPreviousExerciseIndex ?? currentPreviousExerciseIndex,
        currentPRExerciseIndex: updatedPreviousExerciseIndex ?? currentPRExerciseIndex
    );

    return copiedState;
  }
}
