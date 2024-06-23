import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';
import 'weekly_exercise_count_bar_sub-widgets/weekly_muscle_group_set_counter.dart';

class WeeklyExerciseCountBar extends StatelessWidget {
  const WeeklyExerciseCountBar({super.key});

  @override
  Widget build(BuildContext context) {
    double spacerWidth = 5;
    double spacerHeight = 25;//68;

    return Material(
      elevation: 5,
      shadowColor: Colors.black,
      child: Container(
        height: 25,
        decoration: const BoxDecoration(
            color: Colors.black26,
            border: Border(top: BorderSide(color: Colors.black, width: 3))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
            const WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.chest,
            ),
            SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
            const WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.shoulders,
            ),
            SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
            const WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.biceps,
            ),
            SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
            const WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.triceps,
            ),
            SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
            const WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.back,
            ),
            SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
            const WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.legs,
            ),
            // SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
          ],
        ),
      ),
    );
  }
}
