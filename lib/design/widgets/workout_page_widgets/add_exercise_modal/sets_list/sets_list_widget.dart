import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/completed_set_card/completed_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/current_set_card/current_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/previous_set_card/previous_set_card_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';

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
                  state.lastExerciseSets.isNotEmpty) {
                Map currentPreviousSet =
                    state.provideMatchingPreviousSet(currentSet!, doneSets);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 5),
                          // color: Colors.black12,
                          child: Row(
                            children: [
                              const Text(
                                "Last Workout",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.black,
                                    decorationThickness: 2),
                              ),
                              Text(
                                ": [${state.date}]",
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 5, right: 25, bottom: 5),
                          // color: Colors.black12,
                          child: Text(
                            "Working Sets: ${state.getPreviousWorkingSets().length}",
                            textScaleFactor: 0.75,
                          ),
                        ),
                      ],
                    ),
                    AnimatedOpacity(
                      opacity: doneSets.length > state.lastExerciseSets.length
                          ? 0.6
                          : 1,
                      duration: const Duration(seconds: 1),
                      child: PreviousSetCard(
                          set: currentPreviousSet['value'],
                          setNumber:
                              doneSets.length > state.lastExerciseSets.length
                                  ? state.lastExerciseSets.length
                                  : doneSets.length + 1),
                    ),
                    CurrentSetCard(
                        currentSet: currentSet,
                        currentPreviousSet: currentPreviousSet['value'])
                  ],
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
