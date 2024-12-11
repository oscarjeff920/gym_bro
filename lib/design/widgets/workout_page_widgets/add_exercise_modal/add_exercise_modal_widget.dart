import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/close_modal_button_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_list_widget.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

import 'exercise_selector_cluster/exercise_selector_cluster_widget.dart';

class AddExerciseModal extends StatelessWidget {
  final bool isOpen;

  const AddExerciseModal({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        ignoring: !isOpen,
        child: AnimatedOpacity(
            opacity: isOpen ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              height: 800,
              child: Stack(children: [
                Padding(
                  // padding: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                      top: 12, left: 12, right: 12, bottom: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BlocBuilder<AddExerciseCubit, AddExerciseState>(
                      builder: (context, state) {
                        // This is a legitimate case for state.selectedMuscleGroup
                        // in the future this will be a mix of primary muscle group colours
                        MuscleGroup? firstPrimaryMuscleGroup = state
                                .workedMuscleGroups
                                .returnPrimaryMuscleGroups()
                                .isEmpty
                            ? null
                            : state.workedMuscleGroups
                                .returnPrimaryMuscleGroups()
                                .first;
                        Color modalColour = firstPrimaryMuscleGroup?.colour ??
                            const Color(0xffA9A9A9);

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          color: modalColour,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ExerciseSelectorCluster(
                                    selectedMuscleGroup:
                                        firstPrimaryMuscleGroup,
                                    workedMuscleGroups:
                                        state.workedMuscleGroups),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: SetsListContainer(
                                        currentSet: state.currentSet,
                                        completedSets: state.setsDone),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment(0, 0.78),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CloseModalButton(
                        isFinished: false,
                      ),
                      CloseModalButton(
                        isFinished: true,
                      ),
                    ],
                  ),
                )
              ]),
            )));
  }
}
