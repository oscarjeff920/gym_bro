import 'package:flutter/material.dart';

class PrimaryMuscleGroupTitle extends StatelessWidget {
  const PrimaryMuscleGroupTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child:
          Center(child: Text("Primary Muscle Group:"))),
    );
  }
}