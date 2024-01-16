import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/enums.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

class MuscleGroupButton extends StatelessWidget {
  const MuscleGroupButton(
      {super.key, required this.muscleGroup, required this.iconColour});

  final MuscleGroup muscleGroup;
  final Color iconColour;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<AddExerciseCubit>(context)
            .selectMuscleGroup(muscleGroup);
      },
      icon: Icon(
        assignIcon(),
        size: 40,
        color: iconColour,
      ),
    );
  }

  IconData assignIcon() {
    switch (muscleGroup) {
      case MuscleGroup.chest:
        return Icons.favorite_outline_sharp;
      case MuscleGroup.shoulders:
        return Icons.emoji_people;
      case MuscleGroup.biceps:
        return Icons.fitness_center;
      case MuscleGroup.triceps:
        return Icons.expand;
      case MuscleGroup.back:
        return Icons.rowing;
      case MuscleGroup.legs:
        return Icons.sports_martial_arts;
    }
  }
}
