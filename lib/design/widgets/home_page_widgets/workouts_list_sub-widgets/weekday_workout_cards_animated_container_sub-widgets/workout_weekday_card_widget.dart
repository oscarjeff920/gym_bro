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
  final WorkoutTableWithExercisesWorkedMuscleGroups? workout;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CardMuscleGroupIcon(
                      muscleGroup: MuscleGroupType.chest, workout: workout!),
                  CardMuscleGroupIcon(
                      muscleGroup: MuscleGroupType.shoulders,
                      workout: workout!),
                  CardMuscleGroupIcon(
                      muscleGroup: MuscleGroupType.biceps, workout: workout!),
                  CardMuscleGroupIcon(
                      muscleGroup: MuscleGroupType.triceps, workout: workout!),
                  CardMuscleGroupIcon(
                      muscleGroup: MuscleGroupType.back, workout: workout!),
                  CardMuscleGroupIcon(
                      muscleGroup: MuscleGroupType.legs, workout: workout!),
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
  const CardMuscleGroupIcon(
      {super.key, required this.muscleGroup, required this.workout});

  final MuscleGroupType muscleGroup;
  final WorkoutTableWithExercisesWorkedMuscleGroups workout;

  @override
  Widget build(BuildContext context) {
    bool showIcon = false;
    // TODO: different colour if muscle group is not primary
    bool isPrimary = true;
    if (workout.getNumWorkingSetsPerMuscleInWorkout(muscleGroup) > 0) {
      showIcon = true;
    }
    double size = 13;
    return SizedBox(
        width: size,
        child: showIcon
            ? Icon(
                assignIcon(muscleGroup),
                size: size,
              )
            : null);
  }
}
