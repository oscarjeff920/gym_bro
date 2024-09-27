import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/completed_set_card/completed_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/current_set_card/current_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/previous_set_card/previous_set_card_headers_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/previous_set_card/previous_set_card_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_state.dart';

class SetsListContainer extends StatelessWidget {
  final CurrentSet currentSet;
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
        BlocBuilder<GetLastExerciseSetsByMovementBloc,
            GetLastExerciseSetsByMovementState>(
          builder: (context, state) {
            String comparisonExerciseDate;
            GeneralExerciseSetModel comparisonSet;
            int? comparisonExerciseWorkingSetNumber;
            int comparisonExerciseTotalWorkingSets;

            if (state is SuccessfulGetLastExerciseSetsByMovementQueryState &&
                state.lastExerciseSetsData['data'].isNotEmpty) {
              List<GeneralExerciseSetModel> lastExerciseSets =
                  state.lastExerciseSetsData['data'];
              GeneralExerciseSetModel movementPR = state.movementPRData['data'];

              // Here we're getting the most relevant set from the previous exercise
              // to display and compare to the current
              int comparisonExerciseSetIndex =
                  state.provideMatchingPreviousSetIndex(
                      currentSet: currentSet,
                      completedSets: completedSets,
                      comparisonExerciseSets: lastExerciseSets);

              return BlocBuilder<DisplayPrCubit, DisplayPrState>(
                builder: (prContext, prState_) {
                  if (prState_.displayedPR) {
                    comparisonExerciseDate = state.movementPRData['dateString'];
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
                    comparisonExerciseWorkingSetNumber = comparisonSet.isWarmUp
                        ? null
                    // we want to display the number of working sets up to
                    // the current working set number, to correctly show
                    // which working set is being displayed
                        : state.getPreviousWorkingSets(lastExerciseSets.sublist(
                                0, comparisonExerciseSetIndex + 1))
                            .length;

                    comparisonExerciseTotalWorkingSets =
                        state.getPreviousWorkingSets(lastExerciseSets).length;
                  }

                  return Column(
                    children: [
                      PreviousSetCardHeaders(
                          isPr: prState_.displayedPR,
                          date: comparisonExerciseDate,
                          workingSetsCount: comparisonExerciseTotalWorkingSets),
                      PreviousSetCard(
                          set: comparisonSet,
                          setNumber: comparisonExerciseWorkingSetNumber),
                      CurrentSetCard(
                          currentSet: currentSet, comparisonSet: comparisonSet)
                    ],
                  );
                },
              );
            }
            return CurrentSetCard(currentSet: currentSet);
          },
        ),
        for (var set in completedSets) CompletedSetCard(set: set)
      ],
    );
  }
}
