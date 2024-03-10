import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';

import 'exercise_tile_base_widget.dart';

class CompletedExerciseTile extends StatelessWidget {
  final Color primaryMuscleGroupColour;
  final GeneralExerciseModel exercise;
  final int tileIndex;

  final double tileSpacingValue;

  const CompletedExerciseTile(
      {super.key,
      required this.primaryMuscleGroupColour,
      required this.tileIndex,
      required this.tileSpacingValue, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return ExerciseTileBase(
      tileColour: primaryMuscleGroupColour,
      centerWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 2, child: Text(exercise.movementName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15), textAlign: TextAlign.center)),
            Text("Working Sets: ${exercise.numWorkingSets.toString()}"),
            Text("Exercise Duration: ${exercise.exerciseDuration}"),
          ],
        ),
      ),
      clickBehaviour: () {
      },
      isTop: tileIndex == 0 || tileIndex == 1 ? true : false,
      tileSpacingValue: tileSpacingValue,
    );
  }
}
