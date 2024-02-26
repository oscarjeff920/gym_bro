import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_cubit.dart';

class NewWorkoutButton extends StatelessWidget {
  const NewWorkoutButton({
    super.key,
  });
  static Color buttonColour = Colors.cyan.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<WorkoutPageWorkoutCubit>(context).buildNewWorkout();
        Navigator.of(context).pushNamed("/new-workout-page");
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