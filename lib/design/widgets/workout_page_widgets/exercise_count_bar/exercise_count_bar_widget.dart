import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';

import 'muscle_group_set_counter_widget.dart';

class ExerciseCountBar extends StatelessWidget {
  const ExerciseCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    double spacerWidth = 5;
    double spacerHeight = 68;

    return Material(
      elevation: 5,
      shadowColor: Colors.black,
      child: Container(
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.black26,
            border: Border(top: BorderSide(color: Colors.black, width: 2))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (MuscleGroup muscleGroup
                        in MuscleGroup.allMuscleGroups.values)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MuscleGroupSetCounter(muscleGroup: muscleGroup),
                          if (muscleGroup !=
                              MuscleGroup.allMuscleGroups.values.last)
                            // only adding division between muscle groups,
                            // and not at the end
                            SizedBox(
                              width: spacerWidth,
                              child: Center(
                                child: Container(
                                  width: 2,
                                  height: spacerHeight,
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
