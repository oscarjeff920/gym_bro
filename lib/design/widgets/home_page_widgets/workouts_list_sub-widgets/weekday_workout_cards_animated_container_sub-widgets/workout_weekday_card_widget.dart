import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_event.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';

class WorkoutCard extends StatelessWidget {
  final bool isToday;
  final DateTime workoutDate;
  final WorkoutTableWithExercisesWorkedMuscleGroups? workout;
  final int numberOfWorkouts;
  final int workoutIndex;

  const WorkoutCard(
      {super.key,
      required this.isToday,
      required this.workoutDate,
      required this.workout,
      this.workoutIndex = 0,
      this.numberOfWorkouts = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isToday
          ? BoxDecoration(
              border: Border.all(color: Colors.orangeAccent, width: 1))
          : null,
      height: 75,
      width: 90,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0), // Square corners
          )),
        ),
        onPressed: workout == null
            ? null
            : () {
                BlocProvider.of<ActiveWorkoutCubit>(context)
                    .loadHomePageWorkoutToState(workout!);
                // fetching movement names to display
                BlocProvider.of<MovementGetNameByIdBloc>(context).add(
                    QueryMovementNameByIdEvent(
                        namelessExercises: workout!.exercises));
                // fetching exerciseSets to display when exercise card is clicked
                BlocProvider.of<ExerciseSetTableOperationsBloc>(context).add(
                    QueryAllExerciseSetsByExerciseEvent(
                        setlessExercises: workout!.exercises));
                Navigator.of(context).pushNamed("/workout-page");
              },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${workoutDate.day < 10 ? '0${workoutDate.day}' : workoutDate.day}"
              "/${workoutDate.month < 10 ? '0${workoutDate.month}' : workoutDate.month}",
              style: TextStyle(color: isToday ? Colors.orange : Colors.black),
              softWrap: true,
              textScaleFactor: 0.70,
            ),
            workout != null
                ? workout!.workoutStartTime != null
                    ? Text(
                        // TODO: if we ever remove the seconds from the start time, we need to remove the substring
                        workout!.workoutStartTime!.substring(
                            0, workout!.workoutStartTime!.length - 3),
                        textScaleFactor: 0.8,
                        style: const TextStyle(color: Colors.black))
                    : const Text("- - - -",
                        style: TextStyle(color: Colors.black))
                : const Icon(
                    Icons.sentiment_dissatisfied_sharp,
                  ),
            const SizedBox(
              height: 8,
            ),
            if (workout != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (MuscleGroup muscleGroup
                      in MuscleGroup.allMuscleGroups.values)
                    CardMuscleGroupIcon(
                        muscleGroup: muscleGroup, workout: workout!)
                ],
              ),
            // This is the little indicator showing which workout is showing
            // if more than 1 workout was done in one day
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
  const CardMuscleGroupIcon(
      {super.key, required this.muscleGroup, required this.workout});

  final MuscleGroup muscleGroup;
  final WorkoutTableWithExercisesWorkedMuscleGroups workout;

  @override
  Widget build(BuildContext context) {
    bool showIcon = false;
    // TODO: different colour if muscle group is not primary
    bool isPrimary = true;
    if (workout.getNumWorkingSetsPerMuscleInWorkout(muscleGroup.type) > 0) {
      showIcon = true;
    }
    double size = 13;
    return SizedBox(
        width: size,
        child: showIcon
            ? Icon(
                muscleGroup.icon,
                size: size,
              )
            : null);
  }
}
