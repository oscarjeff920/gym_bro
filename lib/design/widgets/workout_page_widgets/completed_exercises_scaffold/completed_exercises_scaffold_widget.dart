import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_state.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

import 'exercise_tiles/add_new_exercise_tile_widget.dart';
import 'exercise_tiles/completed_exercise_tile_widget.dart';

class CompletedExercisesScaffold extends StatelessWidget {
  final double tileSpacingValue;
  final List<GeneralExerciseModel> exercises;
  final bool isCurrentWorkout;

  const CompletedExercisesScaffold({
    super.key,
    required this.tileSpacingValue,
    required this.exercises,
    required this.isCurrentWorkout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: tileSpacingValue),
        child: Stack(children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // COMBINE-SPACING!
                    crossAxisSpacing: tileSpacingValue,
                    crossAxisCount: 2),
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0 && isCurrentWorkout) {
                    return AddNewExerciseTile(
                        tileSpacingValue: tileSpacingValue);
                  } else {
                    return CompletedExerciseTile(
                      tileIndex: index,
                      primaryMuscleGroupColour: muscleGroupColours[
                          exercises[isCurrentWorkout ? index - 1 : index]
                              .primaryMuscleGroup]!,
                      tileSpacingValue: tileSpacingValue,
                      exercise: exercises[isCurrentWorkout ? index - 1 : index],
                    );
                  }
                },
                    childCount: isCurrentWorkout
                        ? 1 + exercises.length
                        : exercises.length),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: tileSpacingValue),
              child: Ink(
                decoration: BoxDecoration(shape: BoxShape.rectangle),
                width: 50,
                height: 50,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
                    builder: (activeWorkoutContext, activeWorkoutState) {
                      return BlocBuilder<WorkoutTimerCubit, WorkoutTimerState>(
                        builder: (timerContext, timerState) {
                          return TextButton(
                            child: const Icon(
                              Icons.check_box,
                              size: 50,
                            ),
                            onPressed: () {
                              if (exercises.isNotEmpty &&
                                  activeWorkoutState is NewActiveWorkoutState) {
                                BlocProvider.of<WorkoutTimerCubit>(context)
                                    .stopTimer();
                                BlocProvider.of<WorkoutTableOperationsBloc>(
                                        context)
                                    .add(InsertNewWorkoutIntoTableEvent(
                                        newWorkout: NewWorkoutModel(
                                            day: activeWorkoutState.day,
                                            month: activeWorkoutState.month,
                                            year: activeWorkoutState.year,
                                            workoutDuration:
                                                timerState.toString(),
                                            exercises: activeWorkoutState.exercises)));
                                BlocProvider.of<WorkoutTimerCubit>(context)
                                    .resetTimer();
                                BlocProvider.of<WorkoutTableOperationsBloc>(context).add(QueryAllWorkoutTableEvent());
                                Navigator.of(context).pushNamed("/");
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
