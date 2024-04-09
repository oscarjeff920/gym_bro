import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

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
                      .addNewExerciseToWorkoutState(state);
                }
                BlocProvider.of<AddExerciseCubit>(context).clearSavedExercise();
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
