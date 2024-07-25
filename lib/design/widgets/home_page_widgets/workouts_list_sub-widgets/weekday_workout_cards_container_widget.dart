import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';

import 'weekday_workout_cards_animated_container_sub-widgets/workout_weekday_card_widget.dart';

class WeekDayWorkoutCardsAnimatedContainer extends StatelessWidget {
  const WeekDayWorkoutCardsAnimatedContainer({
    super.key,
    required this.weekDayIntegerMap,
    required this.weekStartDate,
    required this.workoutsOfTheWeek,
  });

  final Map<int, String> weekDayIntegerMap;
  final DateTime weekStartDate;
  final Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>> workoutsOfTheWeek;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int n = 0; n < 4; n++)
                WeekDayWorkoutScaffold(
                  weekDayIntegerMap: weekDayIntegerMap,
                  n: n,
                  workoutsOfTheWeek: workoutsOfTheWeek,
                  weekStartDate: weekStartDate,
                )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int n = 4; n < 7; n++)
                WeekDayWorkoutScaffold(
                    weekDayIntegerMap: weekDayIntegerMap,
                    n: n,
                    workoutsOfTheWeek: workoutsOfTheWeek,
                    weekStartDate: weekStartDate)
            ],
          ),
        ),
      ],
    );
  }
}

class WeekDayWorkoutScaffold extends StatelessWidget {
  const WeekDayWorkoutScaffold({
    super.key,
    required this.weekDayIntegerMap,
    required this.n,
    required this.workoutsOfTheWeek,
    required this.weekStartDate,
  });

  final Map<int, String> weekDayIntegerMap;
  final int n;
  final Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>> workoutsOfTheWeek;
  final DateTime weekStartDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weekDayIntegerMap[n]!),
        SizedBox(
          width: 90,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: workoutsOfTheWeek[n] != null
                ? Row(
                    children: workoutsOfTheWeek[n]!
                        .asMap()
                        .entries
                        .map(
                          (workout) => WorkoutCard(
                            weekDayIntegerMap: weekDayIntegerMap,
                            n: n,
                            weekStartDate: weekStartDate,
                            workout: workout.value,
                            workoutIndex: workout.key,
                            numberOfWorkouts: workoutsOfTheWeek[n]!.length,
                          ),
                        )
                        .toList())
                : WorkoutCard(
                    weekDayIntegerMap: weekDayIntegerMap,
                    n: n,
                    weekStartDate: weekStartDate,
                    workout: null,
                  ),
          ),
        ),
      ],
    );
  }
}
