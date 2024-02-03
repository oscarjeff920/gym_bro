import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/database/data_models.dart';

import '../../../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

class AddExerciseSetButton extends StatelessWidget {
  final bool isEnabled;

  const AddExerciseSetButton({
    super.key,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      disabledColor: Colors.white54.withOpacity(0),
      onPressed: isEnabled
          ? BlocProvider.of<AddExerciseCubit>(context)
              .updateCurrentSet(const CurrentSet())
          : null,
      style: ButtonStyle(
          iconSize: const MaterialStatePropertyAll(30),
          backgroundColor: MaterialStatePropertyAll(
              Colors.white54.withOpacity(isEnabled ? 0.6 : 0))),
    );
  }
}
