import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';

class FinishSetButton extends StatelessWidget {
  const FinishSetButton({
    super.key,
    required this.currentSet,
  });

  final CurrentSet? currentSet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: SizedBox(
        width: 20,
        height: 20,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: currentSet!.weight != null && currentSet!.reps != null
              ? () {
            BlocProvider.of<SetTimerCubit>(context).stopTimer();
            BlocProvider.of<AddExerciseCubit>(context).updateCurrentSet(
                CurrentSet(
                    setDuration: BlocProvider.of<SetTimerCubit>(context)
                        .returnTimed()));
            BlocProvider.of<AddExerciseCubit>(context).saveCompletedSet();
            BlocProvider.of<SetTimerCubit>(context).resetTimer();
          }
              : null,
          disabledColor: Colors.black.withOpacity(0),
          color: const Color.fromRGBO(0, 200, 0, 1),
          icon: const Icon(
            Icons.check,
            size: 20,
          ),
        ),
      ),
    );
  }
}
