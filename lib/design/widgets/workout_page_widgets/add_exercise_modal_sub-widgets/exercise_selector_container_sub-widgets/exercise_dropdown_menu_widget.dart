import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

class ExerciseDropdownMenu extends StatelessWidget {
  final List matchingExercises;

  const ExerciseDropdownMenu({
    super.key, required this.matchingExercises,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnabled = matchingExercises == [] ? false : true;
    List<DropdownMenuEntry> exerciseEntries = [
      for (var exercise in matchingExercises) DropdownMenuEntry(
          value: exercise, label: exercise
      )
    ];

    return DropdownMenu(
      enabled: isEnabled,
      menuStyle: const MenuStyle(),
      dropdownMenuEntries: exerciseEntries,
      onSelected: (value) {
        BlocProvider.of<AddExerciseCubit>(context)
            .selectExercise(value);
      },
    );
  }
}