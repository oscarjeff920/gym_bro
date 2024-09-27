import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';

class GetLastExerciseSetsByMovementState extends Equatable {
  @override
  List<Object?> get props => [];

  String dateToString(int year, int month, int day) {
    String yearString;
    String monthString;
    String dayString;

    if (year.toString().length > 2) {
      yearString = year.toString().substring(year.toString().length - 2);
    } else {
      yearString = year.toString();
    }

    if (month.toString().length == 1) {
      monthString = "0$month";
    } else {
      monthString = month.toString();
    }

    if (day.toString().length == 1) {
      dayString = "0$day";
    } else {
      dayString = day.toString();
    }

    return "$dayString/$monthString/$yearString";
  }
}

class GetLastExerciseSetNotQueriedState
    extends GetLastExerciseSetsByMovementState {}

class GetLastExerciseSetQueryingState
    extends GetLastExerciseSetsByMovementState {}

class SuccessfulGetLastExerciseSetsByMovementQueryState
    extends GetLastExerciseSetsByMovementState {
  final Map lastExerciseSetsData;
  final Map movementPRData;

  SuccessfulGetLastExerciseSetsByMovementQueryState(
      {required this.lastExerciseSetsData, required this.movementPRData});

  @override
  List<Object?> get props => [lastExerciseSetsData, movementPRData];

  getNumberOfWarmUpSets({required sets}) {
    List<GeneralExerciseSetModel> warmupSets =
        sets.where((exerciseSet) => exerciseSet.isWarmUp == true).toList();
    return warmupSets.length;
  }

  getPreviousWorkingSets(sets) {
    List<GeneralExerciseSetModel> workingSets =
        sets.where((exerciseSet) => exerciseSet.isWarmUp == false).toList();
    return workingSets;
  }

  int provideMatchingPreviousSetIndex(
      {required CurrentSet currentSet,
      required List<GeneralExerciseSetModel> completedSets,
      required List<GeneralExerciseSetModel> comparisonExerciseSets}) {
    if (comparisonExerciseSets.isEmpty) throw Error();

    // We could go two ways for this.
    // 1. If the current set is the first, we do no filtering,
    // But this means:
    // If the user wants to ignore the warm up sets and just look at the working sets
    // they'll be unable to until they've logged their first set:

    // bool isFirstSet = completedSets.isEmpty;
    // if (isFirstSet) return comparisonExerciseSets.first;

    // CURRENT SOLUTION:
    // 2. we only show warm up sets if the current set is ticked as a warmup set
    // Meaning the user can just choose to ignore warmup sets
    // if they've already warmed the muscle group up prior.
    // But this means:
    // They wont see any warm up sets, unless they tick the warmup for current set...

    int numbOfCompletedWarmUpSets = getNumberOfWarmUpSets(sets: completedSets);
    int currentSetIndex = completedSets.length;
    int currentWorkingSetIndex = currentSetIndex - numbOfCompletedWarmUpSets;

    int comparisonSetIndex;
    if (currentSet.isWarmUp!) {
      // If the user has done more sets than last time, the final set will stay displayed
      comparisonSetIndex = getEquivalentWarmupSetIndex(
        currentSetIndex: currentSetIndex,
        comparisonExerciseSets: comparisonExerciseSets
      );
    } else {
      comparisonSetIndex = getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: currentWorkingSetIndex,
          comparisonExerciseSets: comparisonExerciseSets);
    }

    return comparisonSetIndex;
  }

  int getEquivalentWarmupSetIndex({
    required int currentSetIndex,
    required List<GeneralExerciseSetModel> comparisonExerciseSets
}) {
    // gets the warm up set that matches the current set index most closely
    int comparisonSetIndex = currentSetIndex >= comparisonExerciseSets.length
        ? comparisonExerciseSets.length - 1
        : currentSetIndex;
    if (!comparisonExerciseSets[comparisonSetIndex].isWarmUp) {
      for (int index = currentSetIndex -1; index > 0; index--) {
        if (comparisonExerciseSets[index].isWarmUp) return index;
      }
      return 0;
    }
    return comparisonSetIndex;
}

  int getEquivalentWorkingSetIndex({
    required int currentWorkingSetIndex,
    required List<GeneralExerciseSetModel> comparisonExerciseSets,
  }) {
    // gets the working set that matches the current set index most closely
    for (int index = 0; index < comparisonExerciseSets.length; index++) {
      GeneralExerciseSetModel comparisonSet = comparisonExerciseSets[index];
      if (comparisonSet.isWarmUp) continue;
      int equivalentWorkingSetIndex = index + currentWorkingSetIndex;

      if (equivalentWorkingSetIndex >= comparisonExerciseSets.length) {
        for (int i = comparisonExerciseSets.length - 1; i >= 0; i--) {
          if (comparisonExerciseSets[i].isWarmUp) {
            continue;
          }
          return i;
        }
      }
      if (comparisonExerciseSets[equivalentWorkingSetIndex].isWarmUp) {
        continue;
      } else {
        return equivalentWorkingSetIndex;
      }
    }
    throw IndexError.withLength(0, comparisonExerciseSets.length);
  }
}

class GetLastExerciseSetsQueryErrorState
    extends GetLastExerciseSetsByMovementState {
  final Object error;

  GetLastExerciseSetsQueryErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
