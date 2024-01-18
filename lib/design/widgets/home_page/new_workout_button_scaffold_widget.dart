import 'package:flutter/material.dart';

import 'new_workout_button_widget.dart';

class NewWorkoutButtonScaffold extends StatelessWidget {
  const NewWorkoutButtonScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 6, child: Container()),
        const Expanded(
          flex: 1,
          child: Center(
            child: NewWorkoutButton(),
          ),
        ),
        Expanded(flex: 1, child: Container())
      ],
    );
  }
}