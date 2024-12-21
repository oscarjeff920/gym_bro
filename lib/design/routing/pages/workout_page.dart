import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_listener.dart';
import 'package:gym_bro/design/debugging_widgets/debug_state_checker_button_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/backup_current_workout_cubit/backup_current_workout_cubit.dart';
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
    return MultiBlocListener(
      listeners: workoutPageStateListeners(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TheAppBar(),
        body: BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
          builder: (context, state) {
            switch (state) {
              // this checks that there is a workout attached to the ActiveWorkoutState
              case ActiveWorkoutOnState():
                dynamic exercises = [];
                if (state is LoadingActiveWorkoutState) {
                  exercises = state.exercises;
                } else if (state is LoadedActiveWorkoutState) {
                  exercises = state.exercises;
                } else if (state is NewActiveWorkoutState) {
                  exercises = state.exercises;
                }

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

                      // This fades out the area around the add exercise modal
                      // when its opened, to prevent other clicks
                      BlocBuilder<OpenExerciseModalCubit,
                          OpenExerciseModalState>(
                        builder: (context, state) {
                          double fadedValue;
                          switch (state) {
                            case ExerciseModalOpenedState():
                              fadedValue = 0.8;
                            default:
                              fadedValue = 0;
                          }
                          return Stack(children: [
                            IgnorePointer(
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  color: Colors.black.withOpacity(fadedValue)),
                            ),
                            Column(
                              children: [
                                Expanded(
                                  flex: 10,
                                    child:
                                        AddExerciseModal(isOpen: state.isOpen)),
                                SizedBox(height: 70,)
                                // const Spacer()
                              ],
                            )
                          ]);
                        },
                      ),
                    ]),
                  ),
                  const ExerciseCountBar()
                ]);
              default:
                print(
                    "Redirecting to home page as state: $state does not match workout page.");
                return const CircularProgressIndicator();
            }
          },
        ),

        // FOR DEBUG
        floatingActionButton: false ? const DebugStateChecker() : null,
      ),
    );
  }

  List<BlocListener> workoutPageStateListeners() {
    return [
      BlocListener<WorkoutTableOperationsBloc, WorkoutTableOperationsState>(
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
              Navigator.of(context).pushNamed("/");
              BlocProvider.of<WorkoutTimerCubit>(context).resetTimer();
              BlocProvider.of<ActiveWorkoutCubit>(context).resetState();
              BlocProvider.of<BackupCurrentWorkoutCubit>(context)
                  .clearBackedUpWorkout();
            case WorkoutTableInsertErrorState():
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'An error occurred while adding workout to database:\n${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
              BlocProvider.of<SaveErrorStateCubit>(context).writeErrorState(
                  erroredWorkoutMap: state.insertWorkout.toMap(),
                  error: state.error.toString());
          }
        },
      ),
      BlocListener<ActiveWorkoutCubit, ActiveWorkoutState>(
          listener: (context, state) {
        switch (state) {
          case NewActiveWorkoutState():
            BlocProvider.of<BackupCurrentWorkoutCubit>(context)
                .writeCurrentWorkoutState(state.newWorkoutToMap());
        }
      }),
      BlocListener<MovementGetNameByIdBloc, MovementGetNameByIdState>(
          listener: (context, state) {
        switch (state) {
          case MovementGetNameByIdSuccessfulQueryState():
            BlocProvider.of<ActiveWorkoutCubit>(context)
                .loadExerciseNamesToState(state.exerciseMovementNameIndex);
            BlocProvider.of<MovementGetNameByIdBloc>(context)
                .add(ResetMovementGetNameByIdEvent());
        }
      }),
      BlocListener<ExerciseSetTableOperationsBloc,
          ExerciseSetTableOperationsState>(listener: (context, state) {
        switch (state) {
          case ExerciseSetTableSuccessfulQueryAllByExerciseIdState():
            BlocProvider.of<ActiveWorkoutCubit>(context)
                .loadExerciseSetsToState(state.exerciseSetsExerciseIndex);
            BlocProvider.of<ExerciseSetTableOperationsBloc>(context)
                .add(ResetExerciseSetQueryEvent());
        }
      }),
    ];
  }
}
