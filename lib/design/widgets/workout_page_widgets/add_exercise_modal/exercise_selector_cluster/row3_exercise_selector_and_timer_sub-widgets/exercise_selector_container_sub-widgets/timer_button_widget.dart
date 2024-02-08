import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/FE_consts/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';

import '../../../../../../../state_management/cubits/set_timer_cubit/set_timer_state.dart';

class TimerButton extends StatelessWidget {
  final bool isExerciseSelected;

  const TimerButton({
    super.key,
    required this.isExerciseSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetTimerCubit, SetTimerState>(builder: (context, state) {
      Function buttonPressFunction;
      String buttonText;
      switch (state) {
        case SetTimerReset():
          buttonPressFunction =
              () => BlocProvider.of<SetTimerCubit>(context).startTimer();
          buttonText = "Time the Set";
        case SetTimerStarted():
          buttonPressFunction = () {
            BlocProvider.of<SetTimerCubit>(context).stopTimer();
            BlocProvider.of<AddExerciseCubit>(context).updateCurrentSet(
                CurrentSet(setDuration: Duration(seconds: state.elapsed)));
          };
          buttonText = "Stop Timer";
        default:
          buttonPressFunction = () => null;
          buttonText = "Set Finished";
      }
      return TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Colors.white.withOpacity(isExerciseSelected ? 1 : 0.3)),
          ),
          onPressed: isExerciseSelected
              ? () {
                  buttonPressFunction();
                }
              : null,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.timer_outlined),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ]));
    });
  }
}
