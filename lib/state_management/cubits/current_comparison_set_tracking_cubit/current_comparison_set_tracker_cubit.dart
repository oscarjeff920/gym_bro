import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_state.dart';

class CurrentComparisonSetTrackerCubit
    extends Cubit<CurrentComparisonSetTrackerState> {
  CurrentComparisonSetTrackerCubit()
      : super(const CurrentComparisonSetTrackerState(
            currentPreviousExerciseIndex: 0,
            currentPRExerciseIndex: 0,
            maxIndexOfPreviousExerciseSessions: 0,
            maxIndexOfPRExerciseSessions: 0));

  get indexPR => state.currentPRExerciseIndex;
  get indexPreviousExercise => state.currentPreviousExerciseIndex;

  resetIndexStates() {
    emit(const CurrentComparisonSetTrackerState(
        currentPreviousExerciseIndex: 0,
        currentPRExerciseIndex: 0,
        maxIndexOfPreviousExerciseSessions: 0,
        maxIndexOfPRExerciseSessions: 0));
  }

  addMaxIndexes({required int maxIndexPreviousSets, required int maxIndexPR}) {
    CurrentComparisonSetTrackerState generatedState = state.copyWith(
        updatedMaxIndexPreviousSets: maxIndexPreviousSets,
        updatedMaxIndexPR: maxIndexPR);
    emit(generatedState);
  }

  updateCurrentIndex({required bool isPr, required bool isIncrease}) {
    int adjustment = isIncrease ? 1 : -1;

    CurrentComparisonSetTrackerState generatedState;
    if (isPr) {
      generatedState = state.copyWith(
          updatedPRIndex: state.currentPRExerciseIndex + adjustment);
    } else {
      generatedState = state.copyWith(
          updatedPreviousExerciseIndex:
              state.currentPreviousExerciseIndex + adjustment);
    }

    emit(generatedState);
  }
}
