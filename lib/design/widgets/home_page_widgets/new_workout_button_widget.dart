import 'package:flutter/material.dart';

class NewWorkoutButton extends StatelessWidget {
  const NewWorkoutButton({
    super.key,
  });
  static Color buttonColour = Colors.cyan.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
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