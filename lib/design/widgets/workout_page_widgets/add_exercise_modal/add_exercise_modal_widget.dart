import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/close_modal_button_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_list_widget.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

import 'exercise_selector_cluster/exercise_selector_cluster_widget.dart';

class AddExerciseModal extends StatelessWidget {
  const AddExerciseModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: Stack(children: [
        Padding(
          // padding: const EdgeInsets.only(bottom: 10),
          padding:
              const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BlocBuilder<AddExerciseCubit, AddExerciseState>(
              builder: (context, state) {
                Color modalColour = state.selectedMuscleGroup != null
                    ? muscleGroupColours[state.selectedMuscleGroup]!
                    : const Color(0xffA9A9A9);

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  color: modalColour,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ExerciseSelectorCluster(
                            modalColour: modalColour,
                            muscleGroupName: state.muscleGroupToString()),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: SetsList(
                                currentSet: state.currentSet,
                                doneSets: state.setsDone),
                          ),
                        ),
                        // TextButton(
                        //     onPressed: () {
                        //       print(state.toString());
                        //     },
                        //     child: const Text("find out")),
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
    );
  }
}
