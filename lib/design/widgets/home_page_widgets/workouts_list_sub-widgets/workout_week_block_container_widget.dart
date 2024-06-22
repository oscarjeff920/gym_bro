import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/exercise_count_bar/exercise_count_bar_widget.dart';

class WorkoutWeekBlockContainer extends StatelessWidget {
  const WorkoutWeekBlockContainer(
      {super.key,
      required this.workoutsOfTheWeek,
      required this.weekStartDate});

  final DateTime weekStartDate;
  final Map<int, LoadedWorkoutModel> workoutsOfTheWeek;

  @override
  Widget build(BuildContext context) {
    Map<int, String> weekDayIntegerMap = {
      0: "Monday",
      1: "Tuesday",
      2: "Wednesday",
      3: "Thursday",
      4: "Friday",
      5: "Saturday",
      6: "Sunday"
    };

    return SizedBox(
        height: 288,
        child: Container(
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Week Beginning: "
                    "${weekStartDate.day < 10 ? "0${weekStartDate.day}" : weekStartDate.day}/"
                    "${weekStartDate.month < 10 ? "0${weekStartDate.month}" : weekStartDate.month}/"
                    "${weekStartDate.year}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int n = 0; n < 4; n++)
                      WorkoutCard(
                        weekDayIntegerMap: weekDayIntegerMap,
                        n: n,
                        weekStartDate: weekStartDate,
                        workout: workoutsOfTheWeek[n],
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
                      WorkoutCard(
                          weekDayIntegerMap: weekDayIntegerMap,
                          n: n,
                          weekStartDate: weekStartDate)
                  ],
                ),
              ),
              Expanded(
                  flex: 1
                  ,child: ExerciseCountBar())
            ],
          ),
        ));
  }
}

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
