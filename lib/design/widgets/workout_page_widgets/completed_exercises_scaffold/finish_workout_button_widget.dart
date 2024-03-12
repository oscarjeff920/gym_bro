import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class FinishWorkoutButton extends StatelessWidget {
  final int day;
  final int month;
  final int year;
  final List<NewExerciseModel> exercises;

  const FinishWorkoutButton({
    super.key,
    required this.day,
    required this.month,
    required this.year,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutTimerCubit, WorkoutTimerState>(
      builder: (timerContext, timerState) {
        return TextButton(
            onPressed: exercises.isNotEmpty
                ? () {
                    BlocProvider.of<WorkoutTimerCubit>(context).stopTimer();
                    BlocProvider.of<WorkoutTableOperationsBloc>(context).add(
                        InsertNewWorkoutIntoTableEvent(
                            newWorkout: NewWorkoutModel(
                                day: day,
                                month: month,
                                year: year,
                                workoutDuration: timerState.elapsed == 0
                                    ? null
                                    : timerState.toString(),
                                exercises: exercises)));
                    BlocProvider.of<WorkoutTimerCubit>(context).resetTimer();
                    BlocProvider.of<WorkoutTableOperationsBloc>(context)
                        .add(QueryAllWorkoutTableEvent());
                    Navigator.of(context).pushNamed("/");
                  }
                : null,
            child: const Icon(
              Icons.check_box,
              size: 50,
            ));
      },
    );
  }
}
