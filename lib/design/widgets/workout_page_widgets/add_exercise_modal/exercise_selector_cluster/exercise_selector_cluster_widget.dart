import 'package:flutter/material.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row1_title_sub-widgets/primary_muscle_group_heading_container_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row3_exercise_selector_and_timer_sub-widgets/exercise_selector_container_widget.dart';

import 'row2_muscle_group_buttons_sub-widgets/muscle_group_buttons_widget.dart';
import 'row3_exercise_selector_and_timer_sub-widgets/add_new_movement_expanding_widget.dart';

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
    double rowHeight = 70;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryMuscleGroupHeadingContainer(
            currentMuscleGroupName: muscleGroupName, usedHeight: rowHeight),
        MuscleGroupButtons(usedHeight: rowHeight),
        ExerciseSelectorContainer(
            modalColour: modalColour, usedHeight: rowHeight),
        const Padding(
          padding: EdgeInsets.only(top: 5.0, left: 5, right: 5),
          child: AddNewMovementExpandedWidget(),
        ),
      ],
    );
  }
}
