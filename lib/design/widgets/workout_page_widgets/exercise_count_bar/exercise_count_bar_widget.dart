import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';

import 'muscle_group_set_counter_widget.dart';

class ExerciseCountBar extends StatelessWidget {
  const ExerciseCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: Colors.black,
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.black26,
            border: Border(top: BorderSide(color: Colors.black, width: 1))),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.chest,
                    ),
                    MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.shoulders,
                    ),
                    MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.back,
                    ),
                    MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.biceps,
                    ),
                    MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.triceps,
                    ),
                    MuscleGroupSetCounter(
                      muscleGroup: MuscleGroupType.legs,
                    ),
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
