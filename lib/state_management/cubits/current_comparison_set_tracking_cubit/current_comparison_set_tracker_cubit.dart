import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_state.dart';

class CurrentComparisonSetTrackerCubit
    extends Cubit<CurrentComparisonSetTrackerState> {
  CurrentComparisonSetTrackerCubit()
      : super(const CurrentComparisonSetTrackerState(
            currentPreviousExerciseIndex: 0, currentPRExerciseIndex: 0));

  get indexPR => state.currentPRExerciseIndex;
  get indexPreviousExercise => state.currentPreviousExerciseIndex;

  resetIndexState() {
    emit(const CurrentComparisonSetTrackerState(
        currentPreviousExerciseIndex: 0, currentPRExerciseIndex: 0));
  }

  updatePreviousExerciseIndexState(int newIndex) {
    CurrentComparisonSetTrackerState generatedState =
        state.copyWith(updatedPreviousExerciseIndex: newIndex);
    emit(generatedState);
  }

  updatePRIndexState(int newIndex) {
    CurrentComparisonSetTrackerState generatedState =
        state.copyWith(updatedPRIndex: newIndex);
    emit(generatedState);
  }
}
