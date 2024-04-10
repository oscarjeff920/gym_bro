import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';

import '../../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import '../../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class MuscleGroupSetCounter extends StatelessWidget {
  final MuscleGroupType muscleGroup;

  const MuscleGroupSetCounter({
    super.key,
    required this.muscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
      builder: (context, state) {
        int primaryMuscleSets = 0;
        int secondaryMuscleSets = 0;

        switch (state) {
          case LoadedActiveWorkoutState():
            List<LoadedExerciseModel> savedExercises = state.exercises;

            for (var exercise in savedExercises) {
              if (exercise.primaryMuscleGroup == muscleGroup) {
                primaryMuscleSets += exercise.numWorkingSets;
              }
            }
          case NewActiveWorkoutState():
            List<NewExerciseModel> savedExercises = state.exercises;

            for (var exercise in savedExercises) {
              if (exercise.primaryMuscleGroup == muscleGroup) {
                primaryMuscleSets += exercise.numWorkingSets!;
              }
            }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<AddExerciseCubit, AddExerciseState>(
              builder: (context, state) {
                return SizedBox(
                  width: 25,
                  height: 25,
                  child: Center(
                    child: Icon(
                      assignIcon(muscleGroup),
                      color: state.selectedMuscleGroup == null ||
                              state.selectedMuscleGroup == muscleGroup
                          ? muscleGroupColours[muscleGroup]
                          : Colors.grey,
                      size: 30,
                    ),
                  ),
                );
              },
            ),
            // ),
            Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Text(
                      "$primaryMuscleSets |",
                      textScaleFactor: 1.1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 14,
                  height: 14,
                  child: Center(
                    child: Text(
                      "$secondaryMuscleSets",
                      textScaleFactor: 0.9,
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
