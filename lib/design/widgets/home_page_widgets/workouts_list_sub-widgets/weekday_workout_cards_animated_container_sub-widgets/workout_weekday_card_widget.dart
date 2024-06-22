import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard(
      {super.key,
      required this.weekDayIntegerMap,
      required this.n,
      required this.weekStartDate,
      this.workout});

  final Map<int, String> weekDayIntegerMap;
  final int n;
  final DateTime weekStartDate;
  final LoadedWorkoutModel? workout;

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
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(weekDayIntegerMap[n]!),
            Text(
              "${workoutDate.day < 10 ? '0${workoutDate.day}' : workoutDate.day}"
              "/${workoutDate.month < 10 ? '0${workoutDate.month}' : workoutDate.month}",
              softWrap: true,
            ),
            const Icon(Icons.heart_broken_rounded)
          ],
        ),
      ),
    );
  }
}
