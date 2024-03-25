import 'package:flutter/material.dart';

class ContinueWorkoutButton extends StatelessWidget {
  const ContinueWorkoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          Navigator.of(context).pushNamed("/workout-page"),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
                vertical: 5, horizontal: 30)),
        backgroundColor: MaterialStateProperty.all(
            Colors.red.withOpacity(0.8)),
      ),
      child: const Text(
        'Continue Your Workout',
        textScaleFactor: 2,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}