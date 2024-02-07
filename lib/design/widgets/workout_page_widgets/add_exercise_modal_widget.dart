import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

import '../../../enums.dart';
import '../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'add_exercise_modal_sub-widgets/exercise_selector_container_widget.dart';
import 'add_exercise_modal_sub-widgets/primary_muscle_group_buttons_container_widget.dart';
import 'add_exercise_modal_sub-widgets/sets_list_widget.dart';

List<String> mockDropdownList = [
  'Chest Press',
  'Squats',
  'Deadlift',
  'Pull Ups',
  'Shoulder Press',
];

class AddExerciseModal extends StatelessWidget {
  const AddExerciseModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 100),
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    PrimaryMuscleGroupButtonsContainer(
                      currentMuscleGroupName: state.selectedMuscleGroup == null
                          ? null
                          : state.muscleGroupToString(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child:
                          ExerciseSelectorContainer(modalColour: modalColour),
                    ),
                    SetsList(
                        currentSet: state.currentSet, doneSets: state.setsDone),
                    TextButton(
                        onPressed: () {
                          print(state.toString());
                        },
                        child: const Text("find out")),
                    IconButton(
                        alignment: Alignment.bottomRight,
                        onPressed: () {
                          BlocProvider.of<OpenExerciseModalCubit>(context)
                              .closeExerciseModal();
                        },
                        icon: const Icon(Icons.check_circle))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
