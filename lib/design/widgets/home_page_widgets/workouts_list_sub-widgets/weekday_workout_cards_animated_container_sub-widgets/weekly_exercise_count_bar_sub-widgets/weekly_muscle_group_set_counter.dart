import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class WeeklyMuscleGroupSetCounter extends StatelessWidget {
  final MuscleGroupType muscleGroup;

  const WeeklyMuscleGroupSetCounter({
    super.key,
    required this.muscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
      builder: (context, state) {
        int primaryMuscleSets = 0;

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
              height: 25,
              width: totalWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: MuscleIcon(
                      muscleGroup: muscleGroup,
                      totalWorkingSets: 0,
                      iconSize: 20,
                    ),
                  ),
                  // ),
                  Center(
                    child: SizedBox(
                      width: (totalWidth / 2) - 3,
                      child: PrimaryMuscleSetsText(
                          textScaleFactor: 1,
                          primaryMuscleSets: primaryMuscleSets,
                          selectedMuscleGroup: state.selectedMuscleGroup,
                          muscleGroup: muscleGroup),
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
      // "200",
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
    required this.totalWorkingSets,
    required this.iconSize,
  });

  final MuscleGroupType muscleGroup;
  final int totalWorkingSets;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    Color iconColour;
    if (totalWorkingSets == 0) {
      iconColour = Colors.grey;
    }
    else if (totalWorkingSets < 10) {
      iconColour = Colors.black;
    }
    else if (totalWorkingSets < 20) {
      iconColour = muscleGroupColours[muscleGroup]!;
    }
    else {
      iconColour = Colors.white;
    }

    return Icon(
      assignIcon(muscleGroup),
      color: iconColour,
      size: iconSize,
    );
  }
}
