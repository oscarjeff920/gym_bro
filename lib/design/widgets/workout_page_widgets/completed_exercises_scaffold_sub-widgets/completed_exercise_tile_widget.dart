import 'package:flutter/material.dart';

import 'exercise_tile_base_widget.dart';

class CompletedExerciseTile extends StatelessWidget {
  final Color primaryMuscleGroupColour;

  const CompletedExerciseTile(
      {super.key, required this.primaryMuscleGroupColour});

  @override
  Widget build(BuildContext context) {
    return ExerciseTileBase(
      tileColour: primaryMuscleGroupColour,
      centerWidget: Text("details"),
      clickBehaviour: () {
        print("printed again..");
      },
    );
  }
}
