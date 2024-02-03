import 'package:flutter/material.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/completed_exercises_scaffold_sub-widgets/completed_exercise_tile_widget.dart';

import 'completed_exercises_scaffold_sub-widgets/add_new_exercise_tile_widget.dart';

class CompletedExercisesScaffold extends StatelessWidget {
  const CompletedExercisesScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
            delegate: SliverChildBuilderDelegate((context, index) {
              switch (index) {
                case 0:
                  return const AddNewExerciseTile();
                default:
                  return CompletedExerciseTile(
                      primaryMuscleGroupColour: Colors.green);
              }
            }, childCount: 7),
          )
        ],
      );
  }
}
