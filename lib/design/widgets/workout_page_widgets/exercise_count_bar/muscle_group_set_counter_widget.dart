import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../FE_consts/enums.dart';
import '../../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import '../../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class MuscleGroupSetCounter extends StatelessWidget {
  final MuscleGroupType muscleGroup;

  const MuscleGroupSetCounter({
    super.key, required this.muscleGroup,
  });

  @override
  Widget build(BuildContext context) {
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
          "0 |",
          textScaleFactor: 0.9,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          child: Text(
            "0",
            textScaleFactor: 0.73,
            textAlign: TextAlign.start,
          ),
          width: 12,
        )
      ],
    );
  }
}
