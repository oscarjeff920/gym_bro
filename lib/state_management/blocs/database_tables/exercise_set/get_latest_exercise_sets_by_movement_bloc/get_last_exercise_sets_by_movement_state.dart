import 'package:equatable/equatable.dart';
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

  getNumberOfWarmUpSets() {
    List<Sets> warmupSets = lastExerciseSetsData['data']
        .where((exerciseSet) => exerciseSet.isWarmUp == true)
        .toList();
    return warmupSets.length;
  }

  getPreviousWorkingSets() {
    List<Sets> workingSets = lastExerciseSetsData['data']
        .where((exerciseSet) => exerciseSet.isWarmUp == false)
        .toList();
    return workingSets;
  }

  provideMatchingPreviousSet(CurrentSet currentSet, List<Sets> completedSets) {
    if (lastExerciseSetsData['data'].isEmpty) throw Error();
    int totalCompletedSets = completedSets.length;

    List<Sets> lastTimeWorkingSets = [];

    completedSets.asMap().forEach((index, value) {
      if (!value.isWarmUp) lastTimeWorkingSets.add(value);
    });

    int totalSetsLastTime = lastExerciseSetsData['data'].length;
    if (totalSetsLastTime <= totalCompletedSets) {
      return {
        'index': lastExerciseSetsData['data'].length,
        'value': lastExerciseSetsData['data'].last
      };
    }
    // int totalWorkingSetsLastTime = lastTimeWorkingSets.length;
    // int totalWarmupSetsLastTime = totalSetsLastTime - totalWorkingSetsLastTime;
    Sets comparisonSet = lastExerciseSetsData['data'][totalCompletedSets];

    // if the user does more sets than last time, no comparison can be made
    // this is also the case if user wants to do more warm up sets than last time
    if (totalCompletedSets >= totalSetsLastTime ||
        currentSet.isWarmUp == true && !comparisonSet.isWarmUp) {
      print("do summin");
    }

    // if (comparisonSet.isWarmUp && currentSet.isWarmUp == false) {
    //   lastTimeWorkingSets
    // }
    // if (comparisonSet.isWarmUp == currentSet.isWarmUp)
    return {'index': totalCompletedSets, 'value': comparisonSet};
  }
}

class GetLastExerciseSetsQueryErrorState
    extends GetLastExerciseSetsByMovementState {
  final Object error;

  GetLastExerciseSetsQueryErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
