import 'package:flutter/material.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row1_title_sub-widgets/primary_muscle_group_heading_container_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row2_muscle_group_buttons_sub-widgets/muscle_group_button_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row3_exercise_selector_and_timer_sub-widgets/exercise_selector_container_widget.dart';

import '../../../../../enums.dart';

class ExerciseSelectorCluster extends StatelessWidget {
  final Color modalColour;
  final String? muscleGroupName;

  const ExerciseSelectorCluster({
    super.key,
    required this.modalColour,
    this.muscleGroupName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PrimaryMuscleGroupHeadingContainer(
            currentMuscleGroupName:
                muscleGroupName,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var group in MuscleGroup.values.toList())
                MuscleGroupButton(
                  muscleGroup: group,
                )
            ],
          ),
        ),
        Expanded(
          child: ExerciseSelectorContainer(modalColour: modalColour),
        ),
      ],
    );
  }
}
