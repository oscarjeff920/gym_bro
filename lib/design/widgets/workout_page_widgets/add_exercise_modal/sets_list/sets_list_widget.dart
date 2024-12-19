import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_state.dart';

import 'sets_cards/previous_set_card_headers_widget.dart';
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
                  state.lastExerciseSetsData['data'].isNotEmpty) {
                List<GeneralExerciseSetModel> lastExerciseSets =
                    state.lastExerciseSetsData['data'];
                GeneralExerciseSetModel movementPR =
                    state.movementPRData['data'];

                // Here we're getting the most relevant set from the previous exercise
                // to display and compare to the current
                int comparisonExerciseSetIndex =
                    state.provideMatchingPreviousSetIndex(
                        currentSet: currentSet!,
                        completedSets: completedSets,
                        comparisonExerciseSets: lastExerciseSets);

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
                          state.lastExerciseSetsData['dateString'];
                      comparisonSet =
                          lastExerciseSets[comparisonExerciseSetIndex];
                      // If the comparison set is a warm up, working set number = null
                      comparisonExerciseWorkingSetNumber = comparisonSet
                              .isWarmUp
                          ? null
                          // we want to display the number of working sets up to
                          // the current working set number, to correctly show
                          // which working set is being displayed
                          : state
                              .getPreviousWorkingSets(lastExerciseSets.sublist(
                                  0, comparisonExerciseSetIndex + 1))
                              .length;

                      comparisonExerciseTotalWorkingSets =
                          state.getPreviousWorkingSets(lastExerciseSets).length;
                    }

                    return Column(
                      children: [
                        ComparisonSetCardHeaders(
                            isPr: prState_.displayedPR,
                            date: comparisonExerciseDate,
                            workingSetsCount:
                                comparisonExerciseTotalWorkingSets),
                        GeneralSetContainer(
                            comparisonSet: comparisonSet,
                            setNumber: comparisonExerciseWorkingSetNumber),
                        buildGeneralSetContainer(
                          comparisonSet: comparisonSet,
                        ),
                      ],
                    );
                  },
                );
              }
              // If theres no previous exercise data for this movement:
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
