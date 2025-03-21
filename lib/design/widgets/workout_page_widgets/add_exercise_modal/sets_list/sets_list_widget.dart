import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_cubit.dart';
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
          BlocBuilder<GetLastExerciseSetsByMovementBloc,
              GetLastExerciseSetsByMovementState>(
            builder: (context, state) {
              String comparisonExerciseDate;
              GeneralExerciseSetModel comparisonSet;
              int? comparisonExerciseWorkingSetNumber;
              int comparisonExerciseTotalWorkingSets;

              // this function prevents code duplication when calling an instance
              // of GeneralSetContainer if comparisonSet == null or not
              GeneralSetContainer buildGeneralSetContainer(
                  {GeneralExerciseSetModel? comparisonSet}) {
                return GeneralSetContainer(
                  currentSet: currentSet!,
                  setNumber: currentSet!.isWarmUp!
                      ? null
                      : completedSets.length -
                          state.getNumberOfWarmUpSets(sets: completedSets) +
                          1,
                  comparisonSet: comparisonSet,
                );
              }

              if (state is SuccessfulGetLastExerciseSetsByMovementQueryState &&
                  state.previous10ExerciseSessionsSetsData.isNotEmpty) {
                int currentIndexPreviousExerciseSession =
                    BlocProvider.of<CurrentComparisonSetTrackerCubit>(context)
                        .indexPreviousExercise;
                // int currentIndexPr =
                //     BlocProvider.of<CurrentComparisonSetTrackerCubit>(context)
                //         .indexPR;
                // This is the data for the currently selected/visible exercise session
                Map<String, dynamic> selectedPreviousExerciseSessionSetsData =
                    state.previous10ExerciseSessionsSetsData
                        .elementAt(currentIndexPreviousExerciseSession);
                GeneralExerciseSetModel movementPR =
                    state.movementPRData['data'];

                // Here we set the number of entries of previous exercise sessions
                // so we know when we're at the last for the toggle
                // TODO: PR max index hardcoded to 0 for now as it only retrieves one entry
                BlocProvider.of<CurrentComparisonSetTrackerCubit>(context)
                    .addMaxIndexes(
                        maxIndexPreviousSets:
                            state.previous10ExerciseSessionsSetsData.length - 1,
                        maxIndexPR: 0);

                // Here we're getting the most relevant set from the previous exercise session
                // to display and compare to the current
                int comparisonExerciseSetIndex =
                    state.provideMatchingPreviousSetIndex(
                        currentSet: currentSet!,
                        completedSets: completedSets,
                        comparisonExerciseSets:
                            selectedPreviousExerciseSessionSetsData['sets']);

                return BlocBuilder<DisplayPrCubit, DisplayPrState>(
                  builder: (prContext, prState_) {
                    if (prState_.displayedPR) {
                      comparisonExerciseDate =
                          state.movementPRData['dateString'];
                      comparisonSet = movementPR;
                      comparisonExerciseWorkingSetNumber = null;
                      // TODO: not a fan of setting to 0, but in the future I can add the real value
                      comparisonExerciseTotalWorkingSets = 0;
                    } else {
                      comparisonExerciseDate =
                          selectedPreviousExerciseSessionSetsData['dateString'];

                      // This is the set that matches the current set, from the selected exercise session
                      comparisonSet =
                          selectedPreviousExerciseSessionSetsData['sets']
                              [comparisonExerciseSetIndex];
                      // If the comparison set is a warm up, working set number = null
                      comparisonExerciseWorkingSetNumber = comparisonSet
                              .isWarmUp
                          ? null
                          // we want to display the number of working sets up to
                          // the current working set number, to correctly show
                          // which working set is being displayed
                          : state
                              .getPreviousWorkingSets(
                                  selectedPreviousExerciseSessionSetsData[
                                          'sets']
                                      .sublist(
                                          0, comparisonExerciseSetIndex + 1))
                              .length;

                      comparisonExerciseTotalWorkingSets = state
                          .getPreviousWorkingSets(
                              selectedPreviousExerciseSessionSetsData['sets'])
                          .length;
                    }

                    return Column(
                      children: [
                        ComparisonSetCardHeaders(
                          isPr: prState_.displayedPR,
                          date: comparisonExerciseDate,
                          workingSetsCount: comparisonExerciseTotalWorkingSets,
                          setOrder: comparisonSet.exerciseSetOrder,
                        ),
                        // This is the black comparison set container
                        GeneralSetContainer(
                            comparisonSet: comparisonSet,
                            setNumber: comparisonExerciseWorkingSetNumber),
                        // This is the current set container
                        buildGeneralSetContainer(
                          comparisonSet: comparisonSet,
                        ),
                      ],
                    );
                  },
                );
              }
              // If theres no previous exercise data for this movement
              // just show the current set container
              return currentSet != null
                  ? buildGeneralSetContainer()
                  : Container();
            },
          ),
        const SizedBox(
          height: 15,
        ),
        for (var set in completedSets) GeneralSetContainer(completedSet: set)
      ],
    );
  }
}
