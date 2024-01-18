import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/database/data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import '../../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

List<DropdownMenuEntry> exercises = [
  const DropdownMenuEntry(value: "Pull Downs", label: "Pull Downs"),
  const DropdownMenuEntry(value: "Bench Press", label: "Bench Press"),
  const DropdownMenuEntry(value: "Curls", label: "Curls"),
  const DropdownMenuEntry(value: "Shoulder Press", label: "Shoulder Press"),
  const DropdownMenuEntry(value: "Dumbbell Flies", label: "Dumbbell Flies"),
  const DropdownMenuEntry(value: "Skull Crushers", label: "Skull Crushers"),
];

class ExerciseDropdownList extends StatelessWidget {
  const ExerciseDropdownList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: BlocBuilder<AddExerciseCubit, AddExerciseState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownMenu(
                enabled: true,
                menuStyle: const MenuStyle(),
                dropdownMenuEntries: exercises,
                onSelected: (value) {
                  BlocProvider.of<AddExerciseCubit>(context).selectExercise(
                      value);
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                disabledColor: Colors.white54.withOpacity(0),
                onPressed: () {print("blaa");},
                style: ButtonStyle(
                    iconSize: const MaterialStatePropertyAll(30),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.white54.withOpacity(0.6))),
              )
            ],
          );
        },
      ),
    );
  }
}
