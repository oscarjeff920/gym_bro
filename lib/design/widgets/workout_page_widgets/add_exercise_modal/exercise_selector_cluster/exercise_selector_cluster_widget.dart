import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row1_title_sub-widgets/primary_muscle_group_heading_container_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row3_exercise_selector_and_timer_sub-widgets/exercise_selector_container_widget.dart';

import 'row2_muscle_group_buttons_sub-widgets/muscle_group_buttons_widget.dart';
import 'row3_exercise_selector_and_timer_sub-widgets/add_new_movement_expanding_widget.dart';

class ExerciseSelectorCluster extends StatelessWidget {
  final MuscleGroup? selectedMuscleGroup;
  final MovementWorkedMuscleGroupsType? workedMuscleGroups;

  const ExerciseSelectorCluster(
      {super.key,
      required this.selectedMuscleGroup,
      required this.workedMuscleGroups});

  @override
  Widget build(BuildContext context) {
    double rowHeight = 70;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryMuscleGroupHeadingContainer(
            currentMuscleGroupName: selectedMuscleGroup?.title,
            usedHeight: rowHeight),
        MuscleGroupButtons(usedHeight: rowHeight),
        if (workedMuscleGroups != null &&
            workedMuscleGroups!.workedMuscleGroupsMap.isNotEmpty)
          ExerciseSelectorContainer(
              modalColour: selectedMuscleGroup!.colour, usedHeight: rowHeight),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
          child: workedMuscleGroups != null &&
                  workedMuscleGroups!.workedMuscleGroupsMap.isNotEmpty
              ? const AddNewMovementExpandedWidget()
              : Container(),
        ),
      ],
    );
  }
}
