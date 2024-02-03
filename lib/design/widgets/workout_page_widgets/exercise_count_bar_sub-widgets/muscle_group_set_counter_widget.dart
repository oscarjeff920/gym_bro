import 'package:flutter/material.dart';

import '../../../../enums.dart';

class MuscleGroupSetCounter extends StatelessWidget {
  final MuscleGroup muscleGroup;
  const MuscleGroupSetCounter({
    super.key, required this.muscleGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            assignIcon(muscleGroup),
            color: muscleGroupColours[muscleGroup],
            size: 20,
          ),
        ),
        Text(
          "0 |",
          textScaleFactor: 0.9,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          child: Text(
            "0",
            textScaleFactor: 0.73,
            textAlign: TextAlign.start,
          ),
          width: 12,
        )
      ],
    );
  }
}
