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

        double totalWidth = 60;

        return BlocBuilder<AddExerciseCubit, AddExerciseState>(
          builder: (context, state) {
            return SizedBox(
              height: 65,
              width: totalWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: MuscleIcon(
                      muscleGroup: muscleGroup,
                      selectedMuscleGroup: state.selectedMuscleGroup,
                      iconSize: 34,
                    ),
                  ),
                  // ),
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (totalWidth / 2) - 3,
                          child: PrimaryMuscleSetsText(
                              textScaleFactor: 1.5,
                              primaryMuscleSets: primaryMuscleSets,
                              selectedMuscleGroup: state.selectedMuscleGroup,
                              muscleGroup: muscleGroup),
                        ),
                        SizedBox(
                          width: 5,
                          child: Text(
                            "|",
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: state.selectedMuscleGroup == null ||
                                      state.selectedMuscleGroup ==
                                          muscleGroup
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (totalWidth / 2) - 3,
                          child: SecondaryMuscleSetsText(
                            textScaleFactor: 1.0,
                            secondaryMuscleSets: secondaryMuscleSets,
                            muscleGroup: muscleGroup,
                            selectedMuscleGroup: state.selectedMuscleGroup,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
