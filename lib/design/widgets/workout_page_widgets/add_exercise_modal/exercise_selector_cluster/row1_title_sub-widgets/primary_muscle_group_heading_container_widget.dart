import 'package:flutter/material.dart';

import 'primary_muscle_group_title_widget.dart';

class PrimaryMuscleGroupHeadingContainer extends StatelessWidget {
  final String? currentMuscleGroupName;
  final double usedHeight;

  const PrimaryMuscleGroupHeadingContainer({
    super.key,
    required this.currentMuscleGroupName, required this.usedHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: usedHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: const Color.fromRGBO(5, 5, 5, 0.3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: PrimaryMuscleGroupTitle()),
              if (currentMuscleGroupName == null)
                Expanded(child: Container())
              else
                Expanded(
                  child: Center(
                    child: Text(
                      currentMuscleGroupName!,
                      textScaleFactor: 1.5,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}