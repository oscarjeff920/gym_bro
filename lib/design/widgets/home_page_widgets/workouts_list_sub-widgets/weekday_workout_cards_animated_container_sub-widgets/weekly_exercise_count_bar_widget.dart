import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'weekly_exercise_count_bar_sub-widgets/weekly_muscle_group_set_counter.dart';

class WeeklyExerciseCountBar extends StatelessWidget {
  const WeeklyExerciseCountBar({super.key, required this.workoutsOfTheWeek});

  final Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>
      workoutsOfTheWeek;

  @override
  Widget build(BuildContext context) {
    double spacerWidth = 5;
    double spacerHeight = 25; //68;

    return Material(
      elevation: 5,
      shadowColor: Colors.black,
      child: Container(
        height: 25,
        decoration: const BoxDecoration(
            color: Colors.black26,
            border: Border(top: BorderSide(color: Colors.black, width: 3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.chest,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            SizedBox(
              width: spacerWidth,
              child: Center(
                child: Container(
                  width: 2,
                  height: spacerHeight,
                  color: Colors.black12,
                ),
              ),
            ),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.shoulders,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            SizedBox(
              width: spacerWidth,
              child: Center(
                child: Container(
                  width: 2,
                  height: spacerHeight,
                  color: Colors.black12,
                ),
              ),
            ),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.biceps,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            SizedBox(
              width: spacerWidth,
              child: Center(
                child: Container(
                  width: 2,
                  height: spacerHeight,
                  color: Colors.black12,
                ),
              ),
            ),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.triceps,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            SizedBox(
              width: spacerWidth,
              child: Center(
                child: Container(
                  width: 2,
                  height: spacerHeight,
                  color: Colors.black12,
                ),
              ),
            ),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.back,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            SizedBox(
              width: spacerWidth,
              child: Center(
                child: Container(
                  width: 2,
                  height: spacerHeight,
                  color: Colors.black12,
                ),
              ),
            ),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.legs,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            // SizedBox(width: spacerWidth, child: Center(child: Container(width: 2, height: spacerHeight, color: Colors.black12,),),),
          ],
        ),
      ),
    );
  }
}
