import 'package:flutter/material.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal_sub-widgets/primary_muscle_group_buttons_container_sub-widgets/muscle_group_button_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal_sub-widgets/primary_muscle_group_buttons_container_sub-widgets/primary_muscle_group_title_widget.dart';

import '../../../../enums.dart';

class PrimaryMuscleGroupButtonsContainer extends StatelessWidget {
  final String? currentMuscleGroupName;

  const PrimaryMuscleGroupButtonsContainer({
    super.key,
    required this.currentMuscleGroupName,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: const Color.fromRGBO(5, 5, 5, 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const PrimaryMuscleGroupTitle(),
                        if (currentMuscleGroupName == null)
                          Expanded(child: Container())
                        else
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                child: Text(
                                  currentMuscleGroupName!,
                                  textScaleFactor: 1.5,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var group in MuscleGroup.values.toList())
                      MuscleGroupButton(
                        muscleGroup: group,
                      )
                  ],
                ))
          ],
        ));
  }
}
