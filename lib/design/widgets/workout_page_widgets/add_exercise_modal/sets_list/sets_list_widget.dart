import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_cubit.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_state.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_state.dart';

import 'sets_cards/comparison_set_card_headers_widget.dart';
import 'sets_cards/general_set_container_widget.dart';

class SetsListContainer extends StatelessWidget {
  final CurrentSet? currentSet;
  final List<GeneralExerciseSetModel> completedSets;

  const SetsListContainer({
    super.key,
    required this.currentSet,
    required this.completedSets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (currentSet != null)
          CurrentSetScaffold(
              currentSet: currentSet!, completedSets: completedSets),
        const SizedBox(
          height: 15,
        ),
        for (var set in completedSets) GeneralSetContainer(completedSet: set)
      ],
    );
  }
}

class CurrentSetScaffold extends StatelessWidget {
  const CurrentSetScaffold({
    super.key,
    required this.currentSet,
    required this.completedSets,
  });

  final CurrentSet currentSet;
  final List<GeneralExerciseSetModel> completedSets;

  GeneralSetContainer buildGeneralSetContainer(
      {GeneralExerciseSetModel? comparisonSet,
      required CurrentSet currentSet_,
      required int numberOfWarmupSets}) {
    return GeneralSetContainer(
      currentSet: currentSet_,
      setNumber: currentSet_.isWarmUp!
          ? null
          : (completedSets.length - 1) - numberOfWarmupSets,
      comparisonSet: comparisonSet,
    );
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<GetLastExerciseSetsByMovementBloc,
    //     GetLastExerciseSetsByMovementState>(
    //   builder: (context, state) {
    //     if (state is SuccessfulGetLastExerciseSetsByMovementQueryState &&
    //         state.previous10ExerciseSessionsSetsData.isNotEmpty) {
    // int selectedPreviousExerciseSessionIndex =
    //     BlocProvider
    //         .of<CurrentComparisonSetTrackerCubit>(context)
    //         .getCurrentPreviousExerciseSessionIndex;
    // // int currentIndexPr =
    // //     BlocProvider.of<CurrentComparisonSetTrackerCubit>(context)
    // //         .indexPR;
    // // This is the data for the currently selected/visible exercise session
    // Map<String, dynamic> selectedPreviousExerciseSessionSetsData =
    // state.previous10ExerciseSessionsSetsData.elementAt(
    //     comparisonSetTrackerState.currentPreviousExerciseIndex);
    //
    // GeneralExerciseSetModel movementPR = state.movementPRData.elementAt(
    //     comparisonSetTrackerState.currentPRExerciseIndex)['PR_set'];
    //
    // // Here we set the number of entries of previous exercise sessions
    // // so we know when we're at the last for the toggle
    // BlocProvider.of<CurrentComparisonSetTrackerCubit>(context)
    //     .addMaxIndexes(
    //     maxIndexPreviousSets:
    //     state.previous10ExerciseSessionsSetsData.length - 1,
    //     maxIndexPR: state.movementPRData.length - 1);
    //
    // // Here we're getting the most relevant set from the previous exercise session
    // // to display and compare to the current
    // int comparisonExerciseSetIndex =
    // state.provideMatchingPreviousSetIndex(
    //     currentSet: currentSet,
    //     completedSets: completedSets,
    //     comparisonExerciseSets:
    //     selectedPreviousExerciseSessionSetsData['sets']);
    //
    // return BlocBuilder<DisplayPrCubit, DisplayPrState>(
    //   builder: (prContext, prState_) {
    //     String comparisonExerciseDate;
    //     GeneralExerciseSetModel comparisonSet;
    //     int? comparisonExerciseWorkingSetNumber;
    //     int comparisonExerciseTotalWorkingSets;
    //
    //     if (prState_.displayedPR) {
    //       comparisonExerciseDate = state.movementPRData.elementAt(
    //           selectedPreviousExerciseSessionIndex)['dateString'];
    //       comparisonSet = movementPR;
    //       comparisonExerciseWorkingSetNumber = null;
    //       // TODO: not a fan of setting to 0, but in the future I can add the real value
    //       comparisonExerciseTotalWorkingSets = 0;
    //     } else {
    //       comparisonExerciseDate =
    //       selectedPreviousExerciseSessionSetsData['dateString'];
    //
    //       // This is the set that matches the current set, from the selected exercise session
    //       comparisonSet = selectedPreviousExerciseSessionSetsData['sets']
    //       [comparisonExerciseSetIndex];
    //       // If the comparison set is a warm up, working set number = null
    //       comparisonExerciseWorkingSetNumber = comparisonSet.isWarmUp
    //           ? null
    //       // we want to display the number of working sets up to
    //       // the current working set number, to correctly show
    //       // which working set is being displayed
    //           : state
    //           .getPreviousWorkingSets(
    //           selectedPreviousExerciseSessionSetsData['sets']
    //               .sublist(0, comparisonExerciseSetIndex + 1))
    //           .length;
    //
    //       comparisonExerciseTotalWorkingSets = state
    //           .getPreviousWorkingSets(
    //           selectedPreviousExerciseSessionSetsData['sets'])
    //           .length;
    //     }
    return BlocBuilder<GetLastExerciseSetsByMovementBloc,
        GetLastExerciseSetsByMovementState>(
      builder: (context, state) {
        if (state is SuccessfulGetLastExerciseSetsByMovementQueryState &&
            state.returnData[ComparisonDisplayType.latest]!.isNotEmpty) {

          BlocProvider.of<CurrentComparisonSetTrackerCubit>(context).addMaxIndexes(exerciseSetsByMovementReturnData: state.returnData);
          return Column(
            children: [
              // TODO: this cares about PR and current comparison set
              ComparisonSetCardHeaders(
                exerciseSetsByMovementReturnData: state.returnData,
              ),

              // TODO: This also cares about PR and current comparison set
              // This is the current set container
              BlocBuilder<DisplayPrCubit, DisplayPrState>(
                builder: (displayPrContext, displayPrState) {
                  // TODO: bad name -> displayedComparisonSetType
                  List displayedComparisonSetType = state.returnData[
                      displayPrState.currentDisplayedComparisonSetType]!;

                  return BlocBuilder<CurrentComparisonSetTrackerCubit,
                      CurrentComparisonSetTrackerState>(
                    builder: (currentComparisonSetTrackerContext,
                        currentComparisonSetTrackerState) {
                      Map<String, dynamic> currentlyDisplayedComparisonSetData =
                          displayedComparisonSetType.elementAt(
                              currentComparisonSetTrackerState
                                  .getIndexByDisplayType(displayPrState
                                      .currentDisplayedComparisonSetType));

                      GeneralExerciseSetModel comparisonSet;
                      if (displayPrState.isPRDisplayed) {
                        comparisonSet =
                            currentlyDisplayedComparisonSetData['PR_set'];
                      } else {
                        comparisonSet =
                            currentlyDisplayedComparisonSetData['sets']
                                .elementAt(completedSets.length);
                      }

                      return Column(
                        children: [
                          // This is the Comparison Set container
                          GeneralSetContainer(
                              comparisonSet: comparisonSet, setNumber: 4),

                          // This is the Current Set container
                          // it needs info on the comparison set to show est 1RM and other things
                          buildGeneralSetContainer(
                            comparisonSet: comparisonSet,
                            currentSet_: currentSet,
                            numberOfWarmupSets: state.getNumberOfWarmUpSets(
                                sets: completedSets),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
          // },
          // );
        } else {
          // If theres no previous exercise data for this movement
          // just show the current set container
          return buildGeneralSetContainer(
              currentSet_: currentSet,
              numberOfWarmupSets:
                  state.getNumberOfWarmUpSets(sets: completedSets));
        }
      },
    );
  }
}
