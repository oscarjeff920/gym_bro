import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/movement_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/movement_table_operations_state.dart';

import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import '../../../../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import '../../../../../../state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'exercise_selector_container_sub-widgets/exercise_dropdown_menu_widget.dart';
import 'exercise_selector_container_sub-widgets/timer_button_widget.dart';

class ExerciseSelectorContainer extends StatelessWidget {
  final Color modalColour;

  const ExerciseSelectorContainer({
    super.key,
    required this.modalColour,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddExerciseCubit, AddExerciseState>(
      listener: (context, state) {
        if (state.currentSet == null) {
          BlocProvider.of<SetTimerCubit>(context).resetTimer();
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<MovementTableOperationsBloc, MovementTableOperationsState>(
              builder: (context, state) {
                switch (state) {
                  case MovementTableSuccessfulQueryState():
                    return ExerciseDropdownMenu(matchingExercises: state.queryResponse);
                  default:
                    return Container();
                }
              },
            ),
            TimerButton(
                isExerciseSelected:
                state.selectedMovement == null ? false : true)
          ],
        );
      },
    );
  }
}
