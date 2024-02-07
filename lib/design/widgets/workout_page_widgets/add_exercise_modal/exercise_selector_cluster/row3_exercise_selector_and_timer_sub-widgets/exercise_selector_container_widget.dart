import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import '../../../../../../enums.dart';
import '../../../../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'exercise_selector_container_sub-widgets/exercise_dropdown_menu_widget.dart';
import 'exercise_selector_container_sub-widgets/timer_button_widget.dart';

class ExerciseSelectorContainer extends StatelessWidget {
  final Color modalColour;

  const ExerciseSelectorContainer({
    super.key,
    required this.modalColour,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExerciseCubit, AddExerciseState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ExerciseDropdownMenu(
                matchingExercises: state.selectedMuscleGroup != null
                    ? getExercises(state.selectedMuscleGroup!)
                    : []),
            TimerButton()

            // Align(
            //   alignment: Alignment.centerRight,
            //   child: AddExerciseSetButton(
            //       isEnabled: state.selectedExercise != null ? true : false),
            // )
          ],
        );
      },
    );
  }
}