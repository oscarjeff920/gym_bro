import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';

import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class MuscleGroupSetCounter extends StatelessWidget {
  final MuscleGroup muscleGroup;

  const MuscleGroupSetCounter({
    super.key,
    required this.muscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
        builder: (context, state) {
      int primaryMuscleGroupWorkingSets = 0;
      int secondaryMuscleGroupWorkingSets = 0;

      switch (state) {
        case ActiveWorkoutOnState():
          dynamic savedExercises = [];
          if (state is LoadingActiveWorkoutState) {
            savedExercises = state.exercises;
          } else if (state is LoadedActiveWorkoutState) {
            savedExercises = state.exercises;
          } else if (state is NewActiveWorkoutState) {
            savedExercises = state.exercises;
          }

          for (GeneralWorkoutPageExerciseModel exercise in savedExercises) {
            if (exercise.workedMuscleGroups.isMuscleGroupWorkedWithRole(
                muscleGroup.type, RoleType.primary)) {
              primaryMuscleGroupWorkingSets +=
                  exercise.getWorkingSetsPerMuscleGroup(muscleGroup.type);
            } else if (exercise.workedMuscleGroups.isMuscleGroupWorkedWithRole(
                muscleGroup.type, RoleType.secondary)) {
              secondaryMuscleGroupWorkingSets +=
                  exercise.getWorkingSetsPerMuscleGroup(muscleGroup.type);
            }
          }
      }

      double totalWidth = 60;

      return BlocBuilder<AddExerciseCubit, AddExerciseState>(
        builder: (context, state) {
          bool highlightPrimaryMuscleGroup =
              state.workedMuscleGroups.workedMuscleGroupsMap.isEmpty
                  ? true
                  : state.workedMuscleGroups.isMuscleGroupWorkedWithRole(
                      muscleGroup.type, RoleType.primary);
          bool highlightSecondaryMuscleGroup =
              state.workedMuscleGroups.workedMuscleGroupsMap.isEmpty
                  ? true
                  : state.workedMuscleGroups.isMuscleGroupWorkedWithRole(
                      muscleGroup.type, RoleType.secondary);
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
                    highlightMuscleGroup: highlightPrimaryMuscleGroup,
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
                        child: MuscleSetsText(
                          textScaleFactor: 1.5,
                          sets: primaryMuscleGroupWorkingSets,
                          muscleGroup: muscleGroup,
                          highlightMuscleGroup: highlightPrimaryMuscleGroup,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                        child: Text(
                          "|",
                          textScaleFactor: 1.5,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: highlightSecondaryMuscleGroup
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (totalWidth / 2) - 3,
                        child: MuscleSetsText(
                          textScaleFactor: 1.0,
                          sets: secondaryMuscleGroupWorkingSets,
                          muscleGroup: muscleGroup,
                          highlightMuscleGroup: highlightSecondaryMuscleGroup,
                          textAlign: TextAlign.start,
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
    });
  }
}

class MuscleSetsText extends StatelessWidget {
  const MuscleSetsText({
    super.key,
    required this.sets,
    required this.muscleGroup,
    required this.highlightMuscleGroup,
    required this.textScaleFactor,
    this.textAlign = TextAlign.end,
  });

  final int sets;
  final MuscleGroup muscleGroup;
  final bool highlightMuscleGroup;
  final double textScaleFactor;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$sets",
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        // Highlight if no group is selected or the group matches
        color: highlightMuscleGroup ? Colors.black : Colors.grey,
      ),
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
  final MuscleGroup muscleGroup;
  final MuscleGroup? selectedMuscleGroup;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$secondaryMuscleSets",
      textAlign: TextAlign.start,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        // if the user is not looking at a specific muscle group
        // or if the muscle group they are looking at matches
        // the text will look black, otherwise it'll be grey
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
  final MuscleGroup muscleGroup;
  final MuscleGroup? selectedMuscleGroup;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$primaryMuscleSets",
      textAlign: TextAlign.end,
      textScaleFactor: textScaleFactor,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        // if the user is not looking at a specific muscle group
        // or if the muscle group they are looking at matches
        // the text will look black, otherwise it'll be grey
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
    required this.highlightMuscleGroup,
    required this.iconSize,
  });

  final MuscleGroup muscleGroup;
  final bool highlightMuscleGroup;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Icon(
      muscleGroup.icon,
      // if the user is not looking at a specific muscle group
      // or if the muscle group they are looking at matches
      // the text will look the muscle group colour, otherwise it'll be grey
      color: highlightMuscleGroup ? muscleGroup.colour : Colors.grey,
      size: iconSize,
    );
  }
}
