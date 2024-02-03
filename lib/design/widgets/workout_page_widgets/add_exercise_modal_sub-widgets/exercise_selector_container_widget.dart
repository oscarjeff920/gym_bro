import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import '../../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'exercise_selector_container_sub-widgets/add_exercise_set_button_widget.dart';
import 'exercise_selector_container_sub-widgets/exercise_dropdown_menu_widget.dart';

List<String> exercises = [
  "Pull Downs",
  "Bench Press",
  "Curls",
  "Shoulder Press",
  "Dumbbell Flies",
  "Skull Crushers",
];

class ExerciseSelectorContainer extends StatelessWidget {
  final Color modalColour;

  const ExerciseSelectorContainer({
    super.key,
    required this.modalColour,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: BlocBuilder<AddExerciseCubit, AddExerciseState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ExerciseDropdownMenu(
                matchingExercises: state.selectedMuscleGroup != null
                    ? exercises
                    : []
              ),
              AddExerciseSetButton(
                  isEnabled: state.selectedExercise != null
                      ? true
                      : false
              )
            ],
          );
        },
      ),
    );
  }
}