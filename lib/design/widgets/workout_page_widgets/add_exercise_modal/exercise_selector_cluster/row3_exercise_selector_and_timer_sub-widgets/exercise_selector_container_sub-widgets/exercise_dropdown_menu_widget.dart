import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_event.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
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
    TextStyle movementTextStyle = const TextStyle(fontSize: 16);

    return BlocBuilder<AddExerciseCubit, AddExerciseState>(
      builder: (context, state) {
        switch (state.selectedMovement) {
          case null:
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
              textStyle: movementTextStyle,
              leadingIcon: selectedMuscleGroup != null
                  ? Icon(assignIcon(selectedMuscleGroup!))
                  : null,
              label: Text(label),
              dropdownMenuEntries: exerciseEntries,
              onSelected: (value) {
                final int? movementId;

                if (value != addMovementValue) {
                  movementId = value.movementId;
                  BlocProvider.of<AddExerciseCubit>(context)
                      .selectExercise(value);
                  BlocProvider.of<AddNewMovementCubit>(context)
                      .closeAddNewMovementExpansionPanel();
                } else {
                  movementId = null;
                  BlocProvider.of<AddExerciseCubit>(context)
                      .selectMuscleGroup(selectedMuscleGroup!);
                  BlocProvider.of<AddNewMovementCubit>(context)
                      .openAddNewMovementExpansionPanel();
                }
                BlocProvider.of<GetLastExerciseSetsByMovementBloc>(context).add(QueryLastExerciseSetsByMovementEvent(
                movementId: movementId));
              },
            );
          default:
            return Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: SizedBox(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Icon(
                          assignIcon(selectedMuscleGroup!),
                          size: 28,
                        )),
                    Flexible(
                        child: Text(
                      state.selectedMovement!,
                      style: movementTextStyle,
                      softWrap: true,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () =>
                                BlocProvider.of<AddExerciseCubit>(context)
                                    .selectMuscleGroup(selectedMuscleGroup!),
                            icon: const Icon(Icons.delete_forever)))
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
