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

        return BlocBuilder<AddExerciseCubit, AddExerciseState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
                ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 55,
                      height: 30,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width:35,
                              height: 30,
                              child: Text(
                                // "22",
                                "$primaryMuscleSets",
                                textScaleFactor: 1.9,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: state.selectedMuscleGroup == null ||
                                          state.selectedMuscleGroup == muscleGroup
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            Text(
                              "|",
                              textScaleFactor: 1.9,
                              style: TextStyle(
                                color: state.selectedMuscleGroup == null ||
                                        state.selectedMuscleGroup == muscleGroup
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 22,
                      height: 30,
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Text(
                                // "51",
                                "$secondaryMuscleSets",
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: state.selectedMuscleGroup == null ||
                                          state.selectedMuscleGroup == muscleGroup
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
