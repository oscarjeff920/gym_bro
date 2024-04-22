import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';

import 'muscle_group_button_widget.dart';

class MuscleGroupButtons extends StatelessWidget {
  final double usedHeight;

  const MuscleGroupButtons({
    super.key,
    required this.usedHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: usedHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var group in MuscleGroupType.values.toList())
            MuscleGroupButton(
              muscleGroup: group,
            )
        ],
      ),
    );
  }
}
