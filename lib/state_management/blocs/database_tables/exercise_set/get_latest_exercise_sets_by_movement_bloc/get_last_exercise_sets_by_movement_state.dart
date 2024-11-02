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

  int getNumberOfWarmUpSets({required sets}) {
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

    // if either there are no warm-up or no working sets, the current set index will be returned
    if (getNumberOfWarmUpSets(sets: comparisonExerciseSets) == 0 ||
        getNumberOfWarmUpSets(sets: comparisonExerciseSets) ==
            comparisonExerciseSets.length) {
      return currentSetIndex >= comparisonExerciseSets.length
          ? comparisonExerciseSets.length - 1
          : currentSetIndex;
    }

    int comparisonSetIndex;
    if (currentSet.isWarmUp!) {
      // If the user has done more sets than last time, the final set will stay displayed
      comparisonSetIndex = getEquivalentWarmupSetIndex(
          currentSetIndex: currentSetIndex,
          comparisonExerciseSets: comparisonExerciseSets);
    } else {
      comparisonSetIndex = getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: currentWorkingSetIndex,
          comparisonExerciseSets: comparisonExerciseSets);
    }

    return comparisonSetIndex;
  }

  int getEquivalentWarmupSetIndex({
    required int currentSetIndex,
    required List<GeneralExerciseSetModel> comparisonExerciseSets,
  }) {
    /// gets the warm up set that matches the current set index most closely
    if (comparisonExerciseSets.isEmpty) {
      throw ArgumentError('comparisonExerciseSets cannot be empty');
    }

    // if the current set index is greater than the final index of the comparisonExerciseSets
    // we'll take the final set of the comparisonExerciseSets as the comparison
    int comparisonSetIndex = currentSetIndex >= comparisonExerciseSets.length
        ? comparisonExerciseSets.length - 1
        : currentSetIndex;

    // if the comparison set is not a warm up, we loop down until we find one,
    // if none is found we return the comparison set index
    if (!comparisonExerciseSets[comparisonSetIndex].isWarmUp) {
      for (int index = comparisonSetIndex - 1; index >= 0; index--) {
        if (comparisonExerciseSets[index].isWarmUp) return index;
      }
    }
    return comparisonSetIndex;
  }

  int getEquivalentWorkingSetIndex({
    required int currentWorkingSetIndex,
    required List<GeneralExerciseSetModel> comparisonExerciseSets,
  }) {
    /// gets the working set that matches the current set index most closely
    for (int index = 0; index < comparisonExerciseSets.length; index++) {
      GeneralExerciseSetModel comparisonSet = comparisonExerciseSets[index];
      // getting the warm-up sets out of the way
      if (comparisonSet.isWarmUp) continue;

      int equivalentWorkingSetIndex = index + currentWorkingSetIndex;
      if (equivalentWorkingSetIndex >= comparisonExerciseSets.length) {
        // if the equivalent set index is greater than the final index
        // we loop back and select the last working set.
        for (int i = comparisonExerciseSets.length - 1; i >= 0; i--) {
          if (comparisonExerciseSets[i].isWarmUp) continue;
          return i;
          // the case that all sets are warmup is caught outside of this method
        }
      }
      // this is the working set index/element after the initial warmup sets are skipped
      GeneralExerciseSetModel equivalentComparisonExerciseSet =
          comparisonExerciseSets[equivalentWorkingSetIndex];
      if (equivalentComparisonExerciseSet.isWarmUp) {
        // if the equivalent comparison set is a warm up, we'll return the next working set index
        for (int index_ = equivalentWorkingSetIndex + 1;
            index_ < comparisonExerciseSets.length;
            index_++) {
          GeneralExerciseSetModel followingComparisonExerciseSet =
              comparisonExerciseSets[index_];
          if (followingComparisonExerciseSet.isWarmUp) continue;
          return index_;
        }
        // if there are no more working sets, then the last working set index is returned
        for (int i = comparisonExerciseSets.length - 1; i >= 0; i--) {
          if (comparisonExerciseSets[i].isWarmUp) continue;
          return i;
        }
      } else {
        return equivalentWorkingSetIndex;
      }
    }
    throw ArgumentError('comparisonExerciseSets cannot be empty');
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
}

class GetLastExerciseSetsQueryErrorState
    extends GetLastExerciseSetsByMovementState {
  final Object error;

  GetLastExerciseSetsQueryErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
