import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';

class WeeklyMuscleGroupSetCounter extends StatelessWidget {
  final MuscleGroupType muscleGroup;
  final Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>
      workoutsOfTheWeek;

  const WeeklyMuscleGroupSetCounter(
      {super.key, required this.muscleGroup, required this.workoutsOfTheWeek});

  @override
  Widget build(BuildContext context) {
    int muscleGroupWorkingSets = 0;
    for (var day in workoutsOfTheWeek.values) {
      for (var workout in day) {
        muscleGroupWorkingSets +=
            workout.getNumWorkingSetsPerMuscleInWorkout(muscleGroup);
      }
    }

    double totalWidth = 60;
    return SizedBox(
      height: 25,
      width: totalWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MuscleIcon(
              muscleGroup: muscleGroup,
              totalWorkingSets: muscleGroupWorkingSets,
              iconSize: 20,
            ),
          ),
          Center(
            child: SizedBox(
              width: (totalWidth / 2) - 3,
              child: MuscleSetsText(
                  textScaleFactor: 1,
                  sets: muscleGroupWorkingSets,
                  muscleGroup: muscleGroup),
            ),
          ),
        ],
      ),
    );
  }
}

class MuscleSetsText extends StatelessWidget {
  const MuscleSetsText({
    super.key,
    required this.sets,
    required this.muscleGroup,
    required this.textScaleFactor,
  });

  final int sets;
  final MuscleGroupType muscleGroup;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    Color textColour;
    if (sets == 0) {
      textColour = Colors.grey;
    } else if (sets < 10) {
      textColour = Colors.black;
    } else if (sets < 20) {
      textColour = muscleGroupColours[muscleGroup]!;
    } else {
      textColour = Colors.white;
    }
    return Text(
      "$sets",
      textAlign: TextAlign.end,
      textScaleFactor: textScaleFactor,
      style: TextStyle(fontWeight: FontWeight.bold, color: textColour),
    );
  }
}

class MuscleIcon extends StatelessWidget {
  const MuscleIcon({
    super.key,
    required this.muscleGroup,
    required this.totalWorkingSets,
    required this.iconSize,
  });

  final MuscleGroupType muscleGroup;
  final int totalWorkingSets;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    Color iconColour;
    if (totalWorkingSets == 0) {
      iconColour = Colors.grey;
    } else if (totalWorkingSets < 10) {
      iconColour = Colors.black;
    } else if (totalWorkingSets < 20) {
      iconColour = muscleGroupColours[muscleGroup]!;
    } else {
      iconColour = Colors.white;
    }

    return Icon(
      assignIcon(muscleGroup),
      color: iconColour,
      size: iconSize,
    );
  }
}
