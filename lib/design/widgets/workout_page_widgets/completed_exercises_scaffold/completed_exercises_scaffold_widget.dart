import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';

import 'exercise_tiles/add_new_exercise_tile_widget.dart';
import 'exercise_tiles/completed_exercise_tile_widget.dart';
import 'finish_workout_button_widget.dart';

class CompletedExercisesScaffold extends StatelessWidget {
  final double tileSpacingValue;
  final List<GeneralExerciseModel> exercises;
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
        child: Stack(children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // COMBINE-SPACING!
                    crossAxisSpacing: tileSpacingValue,
                    crossAxisCount: 2),
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0 && isCurrentWorkout) {
                    return AddNewExerciseTile(
                        tileSpacingValue: tileSpacingValue);
                  } else {
                    return CompletedExerciseTile(
                      tileIndex: index,
                      primaryMuscleGroupColour: muscleGroupColours[
                          exercises[isCurrentWorkout ? index - 1 : index]
                              .primaryMuscleGroup]!,
                      tileSpacingValue: tileSpacingValue,
                      exercise: exercises[isCurrentWorkout ? index - 1 : index],
                    );
                  }
                },
                    childCount: isCurrentWorkout
                        ? 1 + exercises.length
                        : exercises.length),
              )
            ],
          ),
          BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
              builder: (activeWorkoutContext, activeWorkoutState) {
            switch (activeWorkoutState) {
              case NewActiveWorkoutState():
                return Align(
                    alignment: Alignment.bottomRight,
                    child: FinishWorkoutButton(
                      day: activeWorkoutState.day,
                      month: activeWorkoutState.month,
                      year: activeWorkoutState.year,
                      workoutStartTime: activeWorkoutState.workoutStartTime,
                      exercises: activeWorkoutState.exercises,
                      tileSpacingValue: tileSpacingValue,
                    ));
              default:
                return Container();
            }
          }),
        ]));
  }
}
