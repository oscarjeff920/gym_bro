import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';

// class CurrentComparisonSetTrackerState extends Equatable {
//   final int currentPreviousExerciseIndex;
//   final int maxIndexOfPreviousExerciseSessions;
//   final int currentPRExerciseIndex;
//   final int maxIndexOfPRExerciseSessions;
//
//   const CurrentComparisonSetTrackerState(
//       {required this.currentPreviousExerciseIndex,
//       required this.maxIndexOfPreviousExerciseSessions,
//       required this.currentPRExerciseIndex,
//       required this.maxIndexOfPRExerciseSessions});
//
//   @override
//   get props => [
//         currentPreviousExerciseIndex,
//         maxIndexOfPreviousExerciseSessions,
//         currentPRExerciseIndex,
//         maxIndexOfPRExerciseSessions
//       ];
//
//   copyWith(
//       {int? updatedPreviousExerciseIndex,
//       int? updatedMaxIndexPreviousSets,
//       int? updatedPRIndex,
//       int? updatedMaxIndexPR}) {
//     CurrentComparisonSetTrackerState copiedState =
//         CurrentComparisonSetTrackerState(
//             currentPreviousExerciseIndex: updatedPreviousExerciseIndex ??
//                 currentPreviousExerciseIndex,
//             maxIndexOfPreviousExerciseSessions: updatedMaxIndexPreviousSets ??
//                 maxIndexOfPreviousExerciseSessions,
//             currentPRExerciseIndex: updatedPRIndex ?? currentPRExerciseIndex,
//             maxIndexOfPRExerciseSessions:
//                 updatedMaxIndexPR ?? maxIndexOfPRExerciseSessions);
//
//     return copiedState;
//   }
// }

class CurrentComparisonSetTrackerState extends Equatable {
  final Map<ComparisonDisplayType, Map<CurrentComparisonSetDataType, int>>
      currentComparisonSetData;

  const CurrentComparisonSetTrackerState(
      {required this.currentComparisonSetData});

  @override
  get props => [currentComparisonSetData];

  get previousExerciseIndex =>
      currentComparisonSetData[ComparisonDisplayType.latest]![
          CurrentComparisonSetDataType.currentIndex]!;

  get previousExerciseMaxIndex => currentComparisonSetData[
      ComparisonDisplayType.latest]![CurrentComparisonSetDataType.maxIndex]!;

  get PRExerciseIndex => currentComparisonSetData[ComparisonDisplayType.PR]![
      CurrentComparisonSetDataType.currentIndex]!;

  get PRExerciseMaxIndex => currentComparisonSetData[ComparisonDisplayType.PR]![
      CurrentComparisonSetDataType.maxIndex]!;

  int getIndexByDisplayType(ComparisonDisplayType displayType) {
    return currentComparisonSetData[displayType]![
        CurrentComparisonSetDataType.currentIndex]!;
  }

  int getMaxIndexByDisplayType(ComparisonDisplayType displayType) {
    return currentComparisonSetData[displayType]![
    CurrentComparisonSetDataType.maxIndex]!;
  }

  bool isIndexAtMax(ComparisonDisplayType displayType) {
    int currentIndex = getIndexByDisplayType(displayType);
    int maxIndex = getMaxIndexByDisplayType(displayType);
    return  currentIndex >= maxIndex;
  }

  bool indexNotAtMax(ComparisonDisplayType displayType) {
    int currentIndex = getIndexByDisplayType(displayType);
    int maxIndex = getMaxIndexByDisplayType(displayType);
    return currentIndex < maxIndex;
  }

  bool isIndexAtMin(ComparisonDisplayType displayType) {
    int currentIndex = getIndexByDisplayType(displayType);
    return currentIndex <= 0;
  }

  bool indexNotAtMin(ComparisonDisplayType displayType) {
    int currentIndex = getIndexByDisplayType(displayType);
    return currentIndex > 0;
  }

  copyWith(
      {int? newPreviousExerciseIndex,
      int? newMaxIndexPreviousSets,
      int? newPRIndex,
      int? newMaxIndexPR,
      Map<ComparisonDisplayType, int>? newIndexMap}) {
    int updatedExerciseIndex = newIndexMap?[ComparisonDisplayType.latest] ??
        newPreviousExerciseIndex ??
        previousExerciseIndex;
    int updatedMaxIndexPreviousSets =
        newMaxIndexPreviousSets ?? previousExerciseMaxIndex;
    int updatedPRIndex =
        newIndexMap?[ComparisonDisplayType.PR] ?? newPRIndex ?? PRExerciseIndex;
    int updatedMaxIndexPR = newMaxIndexPR ?? PRExerciseMaxIndex;

    CurrentComparisonSetTrackerState copiedState =
        CurrentComparisonSetTrackerState(
      currentComparisonSetData: {
        ComparisonDisplayType.latest: {
          CurrentComparisonSetDataType.currentIndex: updatedExerciseIndex,
          CurrentComparisonSetDataType.maxIndex: updatedMaxIndexPreviousSets
        },
        ComparisonDisplayType.PR: {
          CurrentComparisonSetDataType.currentIndex: updatedPRIndex,
          CurrentComparisonSetDataType.maxIndex: updatedMaxIndexPR
        }
      },
    );

    return copiedState;
  }
}
