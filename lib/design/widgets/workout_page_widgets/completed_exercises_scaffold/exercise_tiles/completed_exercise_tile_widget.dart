import 'package:flutter/material.dart';

import 'exercise_tile_base_widget.dart';

class CompletedExerciseTile extends StatelessWidget {
  final Color primaryMuscleGroupColour;
  final int tileIndex;

  final double tileSpacingValue;

  const CompletedExerciseTile(
      {super.key,
      required this.primaryMuscleGroupColour,
      required this.tileIndex,
      required this.tileSpacingValue});

  @override
  Widget build(BuildContext context) {
    return ExerciseTileBase(
      tileColour: primaryMuscleGroupColour,
      centerWidget: Text("details"),
      clickBehaviour: () {
        print("printed again..");
      },
      isTop: tileIndex == 1 ? true : false,
      tileSpacingValue: tileSpacingValue,
    );
  }
}
