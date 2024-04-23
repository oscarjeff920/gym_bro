import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/movement_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/movement_table_operations_state.dart';

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
          MuscleGroupType? selectedMuscleGroup =
              addExerciseState.selectedMuscleGroup;
          return BlocBuilder<MovementTableOperationsBloc,
              MovementTableOperationsState>(
            builder: (context, state) {
              List<MovementMuscleGroupJoin> dropdownList = [];
              switch (state) {
                case MovementTableSuccessfulQueryState():
                  dropdownList = state.queryResponse;
              }
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: state is MovementTableSuccessfulQueryState ? 1 : 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ExerciseDropdownMenu(
                        selectedMuscleGroup: selectedMuscleGroup,
                        matchingExercises: dropdownList),
                    TimerButton(
                        isExerciseSelected:
                            addExerciseState.selectedMovement == null
                                ? false
                                : true)
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
