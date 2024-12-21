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
    return LayoutBuilder(builder: (context, constraints) {
      print("Max height => ${constraints.maxHeight}");
      return IgnorePointer(
        ignoring: !isOpen,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: AnimatedContainer(
                  height: !isOpen ? 0 : constraints.maxHeight - 10,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutQuint,
                  child: Stack(children: [
                    ClipRRect(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    if (true)
                      Align(
                        alignment: const Alignment(0, 1),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.easeOut,
                            width: !isOpen ? 0 : constraints.maxWidth,
                            child: AnimatedOpacity(
                              opacity: !isOpen ? 0 : 1,
                              duration: const Duration(milliseconds: 500),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CloseModalButton(
                                    isFinished: false,
                                  ),
                                  CloseModalButton(
                                    isFinished: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ])),
            ),
          ),
        ),
      );
    });
  }
}
