import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_state.dart';
import 'package:gym_bro/state_management/cubits/save_error_state_cubit/save_error_state_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';
import 'package:gym_bro/design/widgets/the_app_bar_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/add_exercise_modal_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/completed_exercises_scaffold/completed_exercises_scaffold_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/exercise_count_bar/exercise_count_bar_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/workout_date_timer_widget.dart';

class WorkoutOverviewPage extends StatelessWidget {
  const WorkoutOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: CHANGE!!!
    double tileSpacingValue = 12;
    return BlocListener<WorkoutTableOperationsBloc,
        WorkoutTableOperationsState>(
      listener: (context, state) {
        switch (state) {
          case WorkoutTableSuccessfulInsertState():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(
                  child: Text(
                    'Successfully Saved Workout!',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );
            BlocProvider.of<WorkoutTimerCubit>(context).resetTimer();
            BlocProvider.of<ActiveWorkoutCubit>(context).resetState();
            Navigator.of(context).pushNamed("/");
          case WorkoutTableInsertErrorState():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'An error occurred while adding workout to database:\n${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
            BlocProvider.of<SaveErrorStateCubit>(context)
                .writeErrorState(state.insertWorkout.toMap());
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TheAppBar(),
        body: BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
            builder: (context, state) {
          List<GeneralExerciseModel> exercises;
          if (state is NewActiveWorkoutState) {
            exercises = state.exercises
                .map((exercise) => exercise.transformToGeneralModel())
                .toList();
          } else if (state is LoadedActiveWorkoutState) {
            exercises = state.exercises
                .map((exercise) => exercise.transformToGeneralModel())
                .toList();
          } else {
            exercises = [];
          }
          if (state is! NewActiveWorkoutState &&
              state is! LoadedActiveWorkoutState) {
            return Container();
          } else {
            state as ActiveWorkoutOnState;

            return Column(children: [
              Material(
                  elevation: 2,
                  child: WorkoutDateTimer(
                    year: state.year,
                    month: state.month,
                    day: state.day,
                    isLoadedWorkout: state is LoadedActiveWorkoutState,
                    workoutDuration: state.workoutDuration,
                  )),
              Expanded(
                child: Stack(children: [
                  Positioned.fill(
                      child: CompletedExercisesScaffold(
                    tileSpacingValue: tileSpacingValue,
                    exercises: exercises,
                    isCurrentWorkout:
                        state is NewActiveWorkoutState ? true : false,
                  )),
                  BlocBuilder<OpenExerciseModalCubit, OpenExerciseModalState>(
                    builder: (context, state) {
                      double fadedValue;
                      switch (state) {
                        case ExerciseModalOpenedState():
                          fadedValue = 0.8;
                        default:
                          fadedValue = 0;
                      }
                      return IgnorePointer(
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            color: Colors.black.withOpacity(fadedValue)),
                      );
                    },
                  ),
                  BlocBuilder<OpenExerciseModalCubit, OpenExerciseModalState>(
                      builder: (context, state) {
                    return IgnorePointer(
                      ignoring: !state.isOpen,
                      child: AnimatedOpacity(
                        opacity: state.isOpen ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const AddExerciseModal()
                      ),
                    );
                  }),
                ]),
              ),
              const ExerciseCountBar()
            ]);
          }
        }),

        // FOR DEBUG
        floatingActionButton: false
            ? BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
                builder: (context, state) {
                  ActiveWorkoutState activeWorkoutState_ = state;
                  return BlocBuilder<ExerciseTableOperationsBloc,
                      ExerciseTableOperationsState>(
                    builder: (context, state) {
                      ExerciseTableOperationsState exerciseTableState = state;
                      return BlocBuilder<AddExerciseCubit, AddExerciseState>(
                        builder: (context, state) {
                          AddExerciseState addExerciseState_ = state;
                          return FloatingActionButton(
                            onPressed: () {
                              print("");
                              print(
                                  "ActiveWorkoutState: $activeWorkoutState_\nExerciseTableOperationsState: $exerciseTableState\nAddExerciseState: $addExerciseState_");
                              print("");
                            },
                          );
                        },
                      );
                    },
                  );
                },
              )
            : null,
      ),
    );
  }
}
