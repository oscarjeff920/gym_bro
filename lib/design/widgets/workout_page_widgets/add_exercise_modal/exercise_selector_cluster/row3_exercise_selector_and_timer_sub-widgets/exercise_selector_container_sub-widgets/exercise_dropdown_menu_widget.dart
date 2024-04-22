import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';

class ExerciseDropdownMenu extends StatelessWidget {
  final List matchingExercises;

  final MuscleGroupType? selectedMuscleGroup;

  const ExerciseDropdownMenu({
    super.key,
    required this.matchingExercises,
    required this.selectedMuscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    String label = "Select Movement";
    String addMovementValue = "new movement";
    bool isEnabled = matchingExercises == [] ? false : true;
    List<DropdownMenuEntry> exerciseEntries = [
      for (var exercise in matchingExercises)
        DropdownMenuEntry(value: exercise, label: exercise.movementName),
      DropdownMenuEntry(
          value: addMovementValue,
          label: "New Movement",
          leadingIcon: const Icon(Icons.add),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)))
    ];

    return DropdownMenu(
      enabled: isEnabled,
      menuStyle: const MenuStyle(
        surfaceTintColor: MaterialStatePropertyAll(Colors.black),
        backgroundColor: MaterialStatePropertyAll(Colors.yellow),
        elevation: MaterialStatePropertyAll(100),
        side: MaterialStatePropertyAll(BorderSide(width: 3)),
      ),
      width: 250,
      menuHeight: 300,
      leadingIcon: selectedMuscleGroup != null ? Icon(assignIcon(selectedMuscleGroup!)) : null,
      label: Text(label),
      dropdownMenuEntries: exerciseEntries,
      onSelected: (value) {
        if (value != addMovementValue) {
          BlocProvider.of<AddExerciseCubit>(context).selectExercise(value);
        } else {
          selectedMuscleGroup ?? BlocProvider.of<AddExerciseCubit>(context).selectMuscleGroup(selectedMuscleGroup!);
          BlocProvider.of<AddNewMovementCubit>(context)
              .openAddNewMovementExpansionPanel();
        }
      },
    );
  }
}
