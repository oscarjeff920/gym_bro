import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_event.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';

import '../../../../state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

class CloseModalButton extends StatelessWidget {
  final bool isFinished;

  const CloseModalButton({
    super.key,
    required this.isFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: BlocBuilder<AddExerciseCubit, AddExerciseState>(
        builder: (context, state) {
          return IconButton(
              onPressed: () {
                if (state.setsDone.isNotEmpty && isFinished) {
                  BlocProvider.of<ActiveWorkoutCubit>(context)
                      .saveFinishedExerciseToWorkoutState(state);
                }

                BlocProvider.of<MovementByMuscleGroupBloc>(context).add(ResetMovementByMuscleGroupEvent());
                BlocProvider.of<GetLastExerciseSetsByMovementBloc>(context).add(ResetGetLastExerciseSetsByMovementEvent());
                BlocProvider.of<AddExerciseCubit>(context).clearSavedExercise();
                BlocProvider.of<AddNewMovementCubit>(context).closeAddNewMovementExpansionPanel();
                BlocProvider.of<OpenExerciseModalCubit>(context)
                    .closeExerciseModal();
              },
              icon: Icon(
                isFinished ? Icons.check_circle : Icons.cancel,
                size: 35,
              ));
        },
      ),
    );
  }
}
