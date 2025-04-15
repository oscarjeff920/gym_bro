import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_state.dart';

class CurrentComparisonSetTrackerCubit
    extends Cubit<CurrentComparisonSetTrackerState> {
  CurrentComparisonSetTrackerCubit()
      : super(CurrentComparisonSetTrackerState(
          currentComparisonSetData: {
            for (ComparisonDisplayType displayType
                in ComparisonDisplayType.values)
              displayType: {
                for (CurrentComparisonSetDataType comparisonSetDataType
                    in CurrentComparisonSetDataType.values)
                  comparisonSetDataType: 0
              }
          },
        ));

  // get getCurrentPRIndex => state.currentPRExerciseIndex;
  //
  // get getCurrentPreviousExerciseSessionIndex =>
  //     state.currentPreviousExerciseIndex;

  resetIndexStates() {
    emit(CurrentComparisonSetTrackerState(
      currentComparisonSetData: {
        for (ComparisonDisplayType displayType in ComparisonDisplayType.values)
          displayType: {
            for (CurrentComparisonSetDataType comparisonSetDataType
                in CurrentComparisonSetDataType.values)
              comparisonSetDataType: 0
          }
      },
    ));
  }

  resetIndex(ComparisonDisplayType selectedComparisonDisplayType) {
    CurrentComparisonSetTrackerState generatedState =
        state.copyWith(newIndexMap: {selectedComparisonDisplayType: 0});

    emit(generatedState);
  }

  resetPreviousExerciseSessionIndex() {
    CurrentComparisonSetTrackerState generatedState =
        state.copyWith(newPreviousExerciseIndex: 0);

    emit(generatedState);
  }

  resetPRIndex() {
    CurrentComparisonSetTrackerState generatedState =
        state.copyWith(newPRIndex: 0);

    emit(generatedState);
  }

  addMaxIndexes(
      {required Map<ComparisonDisplayType, List>
          exerciseSetsByMovementReturnData}) {
    CurrentComparisonSetTrackerState generatedState = state.copyWith(
        newMaxIndexPreviousSets:
            exerciseSetsByMovementReturnData[ComparisonDisplayType.latest]!
                    .length -
                1,
        newMaxIndexPR:
            exerciseSetsByMovementReturnData[ComparisonDisplayType.PR]!.length -
                1);
    emit(generatedState);
  }

  updateCurrentIndex(
      {required ComparisonDisplayType currentDisplayType,
      required bool isIncrease}) {
    int adjustment = isIncrease ? 1 : -1;

    CurrentComparisonSetTrackerState generatedState = state.copyWith(
        newIndexMap: {
          currentDisplayType:
              state.getIndexByDisplayType(currentDisplayType) + adjustment
        });

    // generatedState = state.copyWith()
    // if (isPr) {
    //   generatedState = state.copyWith(
    //       newPRIndex: state.currentPRExerciseIndex + adjustment);
    // } else {
    //   generatedState = state.copyWith(
    //       newPreviousExerciseIndex:
    //       state.currentPreviousExerciseIndex + adjustment);
    // }

    emit(generatedState);
  }
}
