import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import '../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'add_exercise_modal_widget/exercise_dropdown_list_widget.dart';
import 'add_exercise_modal_widget/primary_muscle_group_selector_widget.dart';
import 'add_exercise_modal_widget/sets_list_widget.dart';

List<String> mockDropdownList = [
  'Chest Press',
  'Squats',
  'Deadlift',
  'Pull Ups',
  'Shoulder Press',
];

class AddExerciseModal extends StatelessWidget {
  final Color modalColour;
  final Alignment modalAlignment;
  final double modalWidth;
  final double modalHeight;

  const AddExerciseModal({
    super.key,
    required this.modalColour,
    required this.modalAlignment,
    required this.modalWidth,
    required this.modalHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BlocConsumer<AddExerciseCubit, AddExerciseState>(
          listener: (context, state) {},
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              padding: const EdgeInsets.all(10),
              alignment: modalAlignment,
              width: modalWidth,
              height: modalHeight,
              color: modalColour,
              child: Column(
                children: [
                  PrimaryMuscleGroupWidgets(
                    currentMuscleGroupName: state.selectedMuscleGroup == null
                        ? null
                        : state.muscleGroupToString(),
                  ),
                  const ExerciseDropdownList(),
                  const SetsList(),
                ],
              ),
            );
          },
        ),
      ),
      // IconButton(
      //     onPressed: () {BlocProvider.of<AddExerciseCubit>(context).},
      //     icon: icon)
    ]);
  }
}
