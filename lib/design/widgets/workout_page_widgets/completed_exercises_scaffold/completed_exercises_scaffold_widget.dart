import 'package:flutter/material.dart';

import 'exercise_tiles/add_new_exercise_tile_widget.dart';
import 'exercise_tiles/completed_exercise_tile_widget.dart';

class CompletedExercisesScaffold extends StatelessWidget {
  final double tileSpacingValue;

  const CompletedExercisesScaffold({
    super.key,
    required this.tileSpacingValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: tileSpacingValue),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // COMBINE-SPACING!
                crossAxisSpacing: tileSpacingValue,
                crossAxisCount: 2),
            delegate: SliverChildBuilderDelegate((context, index) {
              switch (index) {
                case 0:
                  return AddNewExerciseTile(tileSpacingValue: tileSpacingValue);
                default:
                  return CompletedExerciseTile(
                    tileIndex: index,
                    primaryMuscleGroupColour: Colors.green,
                    tileSpacingValue: tileSpacingValue,
                  );
              }
            }, childCount: 1 + 0),
          )
        ],
      ),
    );
  }
}
