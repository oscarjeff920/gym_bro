import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';

import 'muscle_group_set_counter_widget.dart';

class ExerciseCountBar extends StatelessWidget {
  const ExerciseCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    double spacerWidth = 10;

    return Material(
      elevation: 5,
      shadowColor: Colors.black,
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.black26,
            border: Border(top: BorderSide(color: Colors.black, width: 1))),
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
                    SizedBox(width: spacerWidth),
                    const MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.chest,
                    ),
                    SizedBox(width: spacerWidth),
                    const MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.shoulders,
                    ),
                    SizedBox(width: spacerWidth),
                    const MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.biceps,
                    ),
                    SizedBox(width: spacerWidth),
                    const MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.triceps,
                    ),
                    SizedBox(width: spacerWidth),
                    const MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.back,
                    ),
                    SizedBox(width: spacerWidth),
                    const MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.legs,
                    ),
                    SizedBox(width: spacerWidth),
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
