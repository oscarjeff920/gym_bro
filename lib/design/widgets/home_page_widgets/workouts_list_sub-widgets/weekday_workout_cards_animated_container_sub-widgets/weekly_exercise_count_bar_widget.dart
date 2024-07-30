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
    Color dividerColour = Colors.black.withOpacity(0.4);

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
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.chest,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            MuscleGroupDivider(spacerWidth: spacerWidth, spacerHeight: spacerHeight, dividerColour: dividerColour),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.shoulders,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            MuscleGroupDivider(spacerWidth: spacerWidth, spacerHeight: spacerHeight, dividerColour: dividerColour),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.biceps,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            MuscleGroupDivider(spacerWidth: spacerWidth, spacerHeight: spacerHeight, dividerColour: dividerColour),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.triceps,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            MuscleGroupDivider(spacerWidth: spacerWidth, spacerHeight: spacerHeight, dividerColour: dividerColour),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.back,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
            MuscleGroupDivider(spacerWidth: spacerWidth, spacerHeight: spacerHeight, dividerColour: dividerColour),
            WeeklyMuscleGroupSetCounter(
              muscleGroup: MuscleGroupType.legs,
              workoutsOfTheWeek: workoutsOfTheWeek,
            ),
          ],
        ),
      ),
    );
  }
}

class MuscleGroupDivider extends StatelessWidget {
  const MuscleGroupDivider({
    super.key,
    required this.spacerWidth,
    required this.spacerHeight,
    required this.dividerColour,
  });

  final double spacerWidth;
  final double spacerHeight;
  final Color dividerColour;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: 2,
          height: spacerHeight,
          color: dividerColour,
        ),
    );
  }
}
