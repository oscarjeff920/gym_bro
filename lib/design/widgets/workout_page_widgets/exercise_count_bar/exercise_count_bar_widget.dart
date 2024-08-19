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
                    for (int i = 0; i < MuscleGroupType.values.length; i++)
                      WorkoutSetCounterBorder(
                      setCounterWidget: MuscleGroupSetCounter(
                        muscleGroup: MuscleGroupType.values[i],
                      ),
                        dividerColour: Colors.black12,
                        first: i == 0,
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

class WorkoutSetCounterBorder extends StatelessWidget {
  final Widget setCounterWidget;
  final Color dividerColour;
  final bool first;

  const WorkoutSetCounterBorder(
      {super.key,
        required this.setCounterWidget,
        this.first = false,
        required this.dividerColour});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: first
            ? null
            : BoxDecoration(
          border: Border(
            left: BorderSide(
              color: dividerColour, // Border color
              width: 3.0, // Border thickness
            ),
          ),
        ),
        child: setCounterWidget);
  }
}
