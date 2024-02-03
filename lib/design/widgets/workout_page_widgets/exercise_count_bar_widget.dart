import 'package:flutter/material.dart';

import '../../../enums.dart';
import 'exercise_count_bar_sub-widgets/muscle_group_set_counter_widget.dart';

class ExerciseCountBar extends StatelessWidget {
  const ExerciseCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          color: Colors.black26,
          border: Border(top: BorderSide(color: Colors.black, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MuscleGroupSetCounter(muscleGroup: MuscleGroup.chest,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroup.shoulders,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroup.biceps,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroup.triceps,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroup.back,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroup.legs,),
        ],
      ),
    );
  }
}
