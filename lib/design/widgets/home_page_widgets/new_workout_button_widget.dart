import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';

class NewWorkoutButton extends StatelessWidget {
  const NewWorkoutButton({
    super.key,
  });
  static Color buttonColour = Colors.cyan.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<ActiveWorkoutCubit>(context).createNewWorkoutState();
        BlocProvider.of<WorkoutTimerCubit>(context).resetTimer();
        BlocProvider.of<SetTimerCubit>(context).resetTimer();
        BlocProvider.of<ExerciseTableOperationsBloc>(context).add(ResetExerciseQueryEvent());
        Navigator.of(context).pushNamed("/workout-page");
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 5, horizontal: 30)
        ),
        backgroundColor: MaterialStateProperty.all(buttonColour),
      ),
      child: const Text(
        'Add a workout!',
        textScaleFactor: 2,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}