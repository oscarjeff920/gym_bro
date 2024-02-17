import 'package:flutter/material.dart';

import '../../../../FE_consts/enums.dart';
import 'muscle_group_set_counter_widget.dart';

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
          MuscleGroupSetCounter(muscleGroup: MuscleGroupType.chest,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroupType.shoulders,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroupType.biceps,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroupType.triceps,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroupType.back,),
          MuscleGroupSetCounter(muscleGroup: MuscleGroupType.legs,),
        ],
      ),
    );
  }
}
