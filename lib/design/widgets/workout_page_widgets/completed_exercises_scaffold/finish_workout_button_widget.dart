import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class FinishWorkoutButton extends StatelessWidget {
  final double tileSpacingValue;
  final int day;
  final int month;
  final int year;
  final String? workoutStartTime;
  final List<WorkoutPageExerciseModel> exercises;

  const FinishWorkoutButton({
    super.key,
    required this.day,
    required this.month,
    required this.year,
    required this.workoutStartTime,
    required this.exercises,
    required this.tileSpacingValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: tileSpacingValue),
      child: Ink(
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        width: 50,
        height: 50,
        child: AspectRatio(
          aspectRatio: 1,
          child: BlocBuilder<WorkoutTimerCubit, WorkoutTimerState>(
            builder: (timerContext, timerState) {
              return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
                builder: (workoutContext, workoutState) {
                  return TextButton(
                      onPressed: exercises.isEmpty
                          ? null
                          : () {
                              BlocProvider.of<WorkoutTimerCubit>(context)
                                  .stopTimer();
                              BlocProvider.of<WorkoutTableOperationsBloc>(
                                      context)
                                  .add(
                                InsertNewWorkoutIntoTableEvent(
                                  newWorkout: NewWorkoutModel(
                                    day: day,
                                    month: month,
                                    year: year,
                                    workoutStartTime: workoutStartTime,
                                    workoutDuration:
                                        (workoutState as NewActiveWorkoutState)
                                                .workoutDuration ??
                                            timerState.toString(),
                                    exercises: exercises,
                                  ),
                                ),
                              );
                            },
                      child: const Icon(
                        Icons.check_box,
                        size: 50,
                      ));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
