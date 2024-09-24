import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/completed_set_card/completed_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/current_set_card/current_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/previous_set_card/previous_set_card_headers_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/previous_set_card/previous_set_card_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_state.dart';

class SetsList extends StatelessWidget {
  final CurrentSet? currentSet;
  final List<Sets> doneSets;

  const SetsList({
    super.key,
    required this.currentSet,
    required this.doneSets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (currentSet != null)
          BlocBuilder<GetLastExerciseSetsByMovementBloc,
              GetLastExerciseSetsByMovementState>(
            builder: (context, state) {
              if (state is SuccessfulGetLastExerciseSetsByMovementQueryState &&
                  state.lastExerciseSetsData['data'].isNotEmpty) {
                Map currentPreviousSet =
                    state.provideMatchingPreviousSet(currentSet!, doneSets);
                return BlocBuilder<DisplayPrCubit, DisplayPrState>(
                  builder: (prContext, prState_) {
                    String displayDate;
                    Sets displaySet;
                    int currentSetNumber;
                    int totalWorkingSetsCount;
                    if (prState_.displayedPR) {
                      displayDate = state.movementPRData['dateString'];
                      displaySet = state.movementPRData['data'];
                      currentSetNumber = 0;
                      totalWorkingSetsCount = 0;
                    } else {
                      displayDate = state.lastExerciseSetsData['dateString'];
                      displaySet = currentPreviousSet['value'];
                      currentSetNumber = displaySet.isWarmUp ? null :
                          state.lastExerciseSetsData['data'].exerciseSetOrder -
                              state.getNumberOfWarmUpSets();
                      totalWorkingSetsCount =
                          state.getPreviousWorkingSets().length;
                    }

                    return Column(
                      children: [
                        PreviousSetCardHeaders(
                            isPr: prState_.displayedPR,
                            date: displayDate,
                            workingSetsCount: totalWorkingSetsCount),
                        PreviousSetCard(
                            set: displaySet, setNumber: currentSetNumber),
                        CurrentSetCard(
                            currentSet: currentSet, comparisonSet: displaySet)
                      ],
                    );
                  },
                );
              }
              return CurrentSetCard(currentSet: currentSet);
            },
          ),
        for (var set in doneSets) CompletedSetCard(set: set)
      ],
    );
  }
}
