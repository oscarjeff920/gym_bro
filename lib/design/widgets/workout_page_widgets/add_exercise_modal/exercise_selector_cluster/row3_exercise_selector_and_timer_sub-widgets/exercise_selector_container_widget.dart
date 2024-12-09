import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_state.dart';

import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'exercise_selector_container_sub-widgets/exercise_dropdown_menu_widget.dart';
import 'exercise_selector_container_sub-widgets/timer_button_widget.dart';

class ExerciseSelectorContainer extends StatelessWidget {
  final Color modalColour;
  final double usedHeight;

  const ExerciseSelectorContainer({
    super.key,
    required this.modalColour,
    required this.usedHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: usedHeight,
      child: BlocConsumer<AddExerciseCubit, AddExerciseState>(
        listener: (context, state) {
          if (state.currentSet == null) {
            BlocProvider.of<SetTimerCubit>(context).resetTimer();
          }
        },
        builder: (addExerciseContext, addExerciseState) {
          MuscleGroup? selectedMuscleGroup =
              addExerciseState.selectedMuscleGroup;
          return BlocBuilder<MovementByMuscleGroupBloc,
              MovementGetByMuscleGroupState>(
            builder: (context, state) {
              List<MovementMuscleGroupJoin> dropdownList = [];
              switch (state) {
                case MovementGetByMuscleGroupSuccessfulQueryState():
                  dropdownList = state.fetchedMovementsList;
              }
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: state is MovementGetByMuscleGroupSuccessfulQueryState ? 1 : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity:
                          state is MovementGetByMuscleGroupSuccessfulQueryState ? 1 : 0,
                      child: ExerciseDropdownMenu(
                          selectedMuscleGroup: selectedMuscleGroup,
                          matchingExercises: dropdownList),
                    ),
                    Opacity(
                      opacity:
                          addExerciseState.selectedMovement != null ? 1 : 0,
                      child: TimerButton(
                          isExerciseSelected:
                              addExerciseState.selectedMovement == null
                                  ? false
                                  : true),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
