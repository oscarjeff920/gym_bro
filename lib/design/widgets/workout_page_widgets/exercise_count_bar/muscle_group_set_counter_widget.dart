import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_state.dart';

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
    return BlocBuilder<WorkoutPageWorkoutCubit, WorkoutPageWorkoutState>(
      builder: (context, state) {
        int primaryMuscleSets = 0;
        int secondaryMuscleSets = 0;
        switch (state) {
          case WorkoutPageDetailsState():
            for (var exercise in state.exercises) {
              if (exercise.primaryMuscleGroup == muscleGroup) {
                primaryMuscleSets += exercise.numWorkingSets;
              }
            }
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: BlocBuilder<AddExerciseCubit, AddExerciseState>(
                builder: (context, state) {
                  return Icon(
                    assignIcon(muscleGroup),
                    color: muscleGroupColours[muscleGroup],
                    size: state.selectedMuscleGroup == muscleGroup ? 30 : 20,
                  );
                },
              ),
            ),
            Text(
              "$primaryMuscleSets |",
              textScaleFactor: 0.9,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              child: Text(
                "$secondaryMuscleSets",
                textScaleFactor: 0.73,
                textAlign: TextAlign.start,
              ),
              width: 12,
            )
          ],
        );
      },
    );
  }
}
