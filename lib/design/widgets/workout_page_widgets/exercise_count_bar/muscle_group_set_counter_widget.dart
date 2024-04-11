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
                    child: MuscleIcon(
                      muscleGroup: muscleGroup,
                      selectedMuscleGroup: state.selectedMuscleGroup,
                      iconSize: 30,
                    ),
                  ),
                ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: Row(
                          children: [
                            PrimaryMuscleSetsText(
                                textScaleFactor: 1.6,
                                primaryMuscleSets: 22,//primaryMuscleSets,
                                selectedMuscleGroup:
                                    state.selectedMuscleGroup,
                                muscleGroup: muscleGroup),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 3,
                                child: Text(
                                  "|",
                                  textScaleFactor: 1.6,
                                  style: TextStyle(
                                    color: state.selectedMuscleGroup == null ||
                                            state.selectedMuscleGroup ==
                                                muscleGroup
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 30,
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: SecondaryMuscleSetsText(
                                textScaleFactor: 1.2,
                                secondaryMuscleSets: 31,//secondaryMuscleSets,
                                muscleGroup: muscleGroup,
                                selectedMuscleGroup: state.selectedMuscleGroup,
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

class SecondaryMuscleSetsText extends StatelessWidget {
  const SecondaryMuscleSetsText({
    super.key,
    required this.secondaryMuscleSets,
    required this.muscleGroup,
    required this.selectedMuscleGroup,
    required this.textScaleFactor,
  });

  final int secondaryMuscleSets;
  final MuscleGroupType muscleGroup;
  final MuscleGroupType? selectedMuscleGroup;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$secondaryMuscleSets",
      textAlign: TextAlign.start,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: selectedMuscleGroup == null || selectedMuscleGroup == muscleGroup
            ? Colors.black
            : Colors.grey,
      ),
    );
  }
}

class PrimaryMuscleSetsText extends StatelessWidget {
  const PrimaryMuscleSetsText({
    super.key,
    required this.primaryMuscleSets,
    required this.muscleGroup,
    required this.selectedMuscleGroup,
    required this.textScaleFactor,
  });

  final int primaryMuscleSets;
  final MuscleGroupType muscleGroup;
  final MuscleGroupType? selectedMuscleGroup;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$primaryMuscleSets",
      textAlign: TextAlign.end,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: selectedMuscleGroup == null || selectedMuscleGroup == muscleGroup
            ? Colors.black
            : Colors.grey,
      ),
    );
  }
}

class MuscleIcon extends StatelessWidget {
  const MuscleIcon({
    super.key,
    required this.muscleGroup,
    required this.selectedMuscleGroup,
    required this.iconSize,
  });

  final MuscleGroupType muscleGroup;
  final MuscleGroupType? selectedMuscleGroup;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Icon(
      assignIcon(muscleGroup),
      color: selectedMuscleGroup == null || selectedMuscleGroup == muscleGroup
          ? muscleGroupColours[muscleGroup]
          : Colors.grey,
      size: iconSize,
    );
  }
}
