import 'package:flutter/material.dart';
import 'package:gym_bro/design/widgets/workout_page/add_exercise_modal_widget/primary_muscle_group_selector/primary_muscle_group_title_widget.dart';

import '../../../../enums.dart';
import 'primary_muscle_group_selector/muscle_group_button_widget.dart';

class PrimaryMuscleGroupWidgets extends StatelessWidget {
  final String? currentMuscleGroupName;

  const PrimaryMuscleGroupWidgets({
    super.key,
    required this.currentMuscleGroupName,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
