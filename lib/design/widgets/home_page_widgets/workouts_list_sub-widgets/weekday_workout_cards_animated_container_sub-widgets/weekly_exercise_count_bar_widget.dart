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
            for (int i = 0; i < MuscleGroupType.values.length; i++)
              Expanded(
                child: WeeklySetCounterBorder(
                  setCounterWidget: WeeklyMuscleGroupSetCounter(
                    muscleGroup: MuscleGroupType.values[i],
                    workoutsOfTheWeek: workoutsOfTheWeek,
                  ),
                  dividerColour: dividerColour,
                  first: i == 0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class WeeklySetCounterBorder extends StatelessWidget {
  final Widget setCounterWidget;
  final Color dividerColour;
  final bool first;

  const WeeklySetCounterBorder(
      {super.key,
      required this.setCounterWidget,
      this.first = false,
      required this.dividerColour});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: first
            ? null
            : BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: dividerColour, // Border color
                    width: 3.0, // Border thickness
                  ),
                ),
              ),
        child: setCounterWidget);
  }
}
