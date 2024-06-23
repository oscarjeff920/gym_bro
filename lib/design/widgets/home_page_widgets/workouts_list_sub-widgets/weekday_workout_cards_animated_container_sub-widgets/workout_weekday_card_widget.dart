import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard(
      {super.key,
      required this.weekDayIntegerMap,
      required this.n,
      required this.weekStartDate,
      required this.workout,
      this.workoutIndex = 0,
      this.numberOfWorkouts = 1});

  final Map<int, String> weekDayIntegerMap;
  final int n;
  final DateTime weekStartDate;
  final LoadedWorkoutModel? workout;
  final int numberOfWorkouts;
  final int workoutIndex;

  @override
  Widget build(BuildContext context) {
    DateTime workoutDate = weekStartDate.add(Duration(days: n));
    return SizedBox(
      height: 75,
      width: 90,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0), // Square corners
          )),
        ),
        onPressed: workout != null ? () {} : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${workoutDate.day < 10 ? '0${workoutDate.day}' : workoutDate.day}"
              "/${workoutDate.month < 10 ? '0${workoutDate.month}' : workoutDate.month}",
              softWrap: true,
              textScaleFactor: 0.70,
            ),
            workout != null
                ? workout!.workoutStartTime != null
                    ? Text(workout!.workoutStartTime!)
                    : const Text("- - - -")
                : const Icon(Icons.sentiment_dissatisfied_sharp),
            const SizedBox(
              height: 8,
            ),
            if (workout != null)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CardMuscleGroupIcon(
                      muscleGroupIcon: Icons.favorite, showIcon: true),
                  CardMuscleGroupIcon(
                      muscleGroupIcon: Icons.emoji_people, showIcon: true),
                  CardMuscleGroupIcon(
                      muscleGroupIcon: Icons.fitness_center, showIcon: true),
                  CardMuscleGroupIcon(
                      muscleGroupIcon: Icons.expand, showIcon: true),
                  CardMuscleGroupIcon(
                      muscleGroupIcon: Icons.rowing, showIcon: true),
                  CardMuscleGroupIcon(
                      muscleGroupIcon: Icons.sports_martial_arts,
                      showIcon: true),
                ],
              ),
            if (workout != null && numberOfWorkouts > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  for (var n = 0; n < numberOfWorkouts; n++)
                    Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2, top: 4),
                      child: Icon(
                        Icons.circle,
                        size: 4,
                        color: n == workoutIndex ? Colors.blue : Colors.grey,
                      ),
                    )
                ],
              )
          ],
        ),
      ),
    );
  }
}

class CardMuscleGroupIcon extends StatelessWidget {
  const CardMuscleGroupIcon({
    super.key,
    required this.muscleGroupIcon,
    required this.showIcon,
  });

  final IconData muscleGroupIcon;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    double size = 13;
    return SizedBox(
        width: size,
        child: showIcon
            ? Icon(
                muscleGroupIcon,
                size: size,
              )
            : null);
  }
}
