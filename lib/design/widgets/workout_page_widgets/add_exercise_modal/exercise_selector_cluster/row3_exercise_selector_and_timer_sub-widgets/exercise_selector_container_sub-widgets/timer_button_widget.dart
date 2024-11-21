import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_state.dart';

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
      Color timerColour = const Color(0xFF7C7C7C);
      switch (state) {
        case SetTimerReset():
          buttonPressFunction = () {
            BlocProvider.of<SetTimerCubit>(context).startTimer();
          };
          buttonText = "Time the Set";
        case SetTimerStarted():
          buttonPressFunction = () {
            BlocProvider.of<SetTimerCubit>(context).stopTimer();
            BlocProvider.of<AddExerciseCubit>(context).updateCurrentSet(
                CurrentSet(
                    setDuration:
                        BlocProvider.of<SetTimerCubit>(context).returnTimed()));
          };
          buttonText = "Stop Timer";
          timerColour = const Color.fromRGBO(255, 0, 0, 1);
        default:
          buttonPressFunction = () => null;
          buttonText = "Set Finished";
      }
      return TextButton(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
                const BorderSide(color: Colors.black, width: 1.5)),
            backgroundColor: WidgetStatePropertyAll<Color>(
                timerColour.withOpacity(isExerciseSelected ? 1 : 0.3)),
          ),
          onPressed: isExerciseSelected
              ? () {
                  buttonPressFunction();
                }
              : null,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: Color.fromRGBO(230, 230, 150, 1),
                ),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(230, 230, 150, 1)),
                ),
              ]));
    });
  }
}
