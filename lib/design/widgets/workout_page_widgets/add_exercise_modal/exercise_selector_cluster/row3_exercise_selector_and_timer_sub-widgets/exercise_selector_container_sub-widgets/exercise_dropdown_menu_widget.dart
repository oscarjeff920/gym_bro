import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_event.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';

class ExerciseDropdownMenu extends StatelessWidget {
  final List matchingExercises;

  final MuscleGroup? selectedMuscleGroup;

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
              backgroundColor: WidgetStateProperty.all(Colors.white)))
    ];
    TextStyle movementTextStyle = const TextStyle(fontSize: 16);

    return BlocBuilder<AddExerciseCubit, AddExerciseState>(
      builder: (context, state) {
        switch (state.selectedMovement) {
          case null:
            return DropdownMenu(
              enabled: isEnabled,
              menuStyle: const MenuStyle(
                surfaceTintColor: WidgetStatePropertyAll(Colors.black),
                backgroundColor: WidgetStatePropertyAll(Colors.yellow),
                elevation: WidgetStatePropertyAll(100),
                side: WidgetStatePropertyAll(BorderSide(width: 3)),
              ),
              width: 250,
              menuHeight: 300,
              textStyle: movementTextStyle,
              leadingIcon: selectedMuscleGroup != null
                  ? Icon(selectedMuscleGroup!.icon)
                  : null,
              label: Text(label),
              dropdownMenuEntries: exerciseEntries,
              onSelected: (value) {
                final int? movementId;
                // we start the workout timer when the first exercise is selected
                BlocProvider.of<WorkoutTimerCubit>(context).beginTimer();

                if (value == addMovementValue) {
                  movementId = null;
                  // TODO: is this necessary?
                  BlocProvider.of<AddExerciseCubit>(context)
                      .selectMuscleGroup(selectedMuscleGroup!);

                  // TODO: this also confuses me...
                  BlocProvider.of<GetLastExerciseSetsByMovementBloc>(context)
                      .add(ResetGetLastExerciseSetsByMovementEvent());

                  BlocProvider.of<AddNewMovementCubit>(context)
                      .openAddNewMovementExpansionPanel();
                  BlocProvider.of<AddNewMovementCubit>(context)
                      .addSelectedMuscleGroupToWorkedMuscleGroups(
                          selectedMuscleGroup!);
                } else {
                  movementId = value.movementId;
                  BlocProvider.of<AddExerciseCubit>(context)
                      .selectExercise(value);
                  BlocProvider.of<GetLastExerciseSetsByMovementBloc>(context)
                      .add(QueryLastExerciseSetsByMovementEvent(
                          movementId: movementId));
                  BlocProvider.of<AddNewMovementCubit>(context)
                      .closeAddNewMovementExpansionPanel();
                }
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
                          selectedMuscleGroup!.icon,
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
