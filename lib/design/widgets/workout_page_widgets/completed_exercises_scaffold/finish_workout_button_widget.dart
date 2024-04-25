import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/save_error_state_cubit/save_error_state_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class FinishWorkoutButton extends StatelessWidget {
  final double tileSpacingValue;
  final int day;
  final int month;
  final int year;
  final String? workoutStartTime;
  final List<NewExerciseModel> exercises;

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
                        try {
                          BlocProvider.of<WorkoutTimerCubit>(context)
                              .stopTimer();
                          // throw Exception("testing snackbar");
                          BlocProvider.of<WorkoutTableOperationsBloc>(context)
                              .add(
                            InsertNewWorkoutIntoTableEvent(
                              newWorkout: NewWorkoutModel(
                                day: day,
                                month: month,
                                year: year,
                                workoutStartTime: workoutStartTime,
                                workoutDuration: timerState.elapsed == 0
                                    ? null
                                    : timerState.toString(),
                                exercises: exercises,
                              ),
                            ),
                          );
                          BlocProvider.of<WorkoutTimerCubit>(context)
                              .resetTimer();
                          BlocProvider.of<WorkoutTableOperationsBloc>(context)
                              .add(QueryAllWorkoutTableEvent());
                          BlocProvider.of<ActiveWorkoutCubit>(context)
                              .resetState();
                          Navigator.of(context).pushNamed("/");
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'An error occurred while adding workout to database: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          NewActiveWorkoutState currentState = workoutState as NewActiveWorkoutState;
                          BlocProvider.of<SaveErrorStateCubit>(context)
                              .writeErrorState(currentState.newWorkoutToMap());
                          // Handle error here
                          print("An error occurred: $e");
                        }
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
