import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_state.dart';

import 'exercise_tiles/add_new_exercise_tile_widget.dart';
import 'exercise_tiles/completed_exercise_tile_widget.dart';

class CompletedExercisesScaffold extends StatelessWidget {
  final double tileSpacingValue;
  final List<ExerciseModel_WorkoutPage> exercises;
  final bool isCurrentWorkout;

  const CompletedExercisesScaffold({
    super.key,
    required this.tileSpacingValue,
    required this.exercises,
    required this.isCurrentWorkout,
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
                if (index == 0 && isCurrentWorkout) {
                  return AddNewExerciseTile(tileSpacingValue: tileSpacingValue);
                } else {
                  return CompletedExerciseTile(
                    tileIndex: index,
                    primaryMuscleGroupColour: muscleGroupColours[exercises[index].primaryMuscleGroup]!,
                    tileSpacingValue: tileSpacingValue, exercise: exercises[index],
                  );
                }
              }, childCount: isCurrentWorkout ? 1 + exercises.length : exercises.length),
            )
          ],
        ));
  }
}
