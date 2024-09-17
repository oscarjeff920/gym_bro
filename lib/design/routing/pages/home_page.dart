import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/src/bloc_listener.dart';
import 'package:gym_bro/design/debugging_widgets/debug_state_checker_button_widget.dart';
import 'package:gym_bro/design/widgets/home_page_widgets/continue_workout_button_widget.dart';
import 'package:gym_bro/design/debugging_widgets/load_errored_workout_button_widget.dart';
import 'package:gym_bro/design/widgets/the_app_bar_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/backup_current_workout_cubit/backup_current_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/backup_current_workout_cubit/backup_current_workout_state.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

import 'package:gym_bro/design/widgets/home_page_widgets/new_workout_button_widget.dart';
import 'package:gym_bro/design/widgets/home_page_widgets/workouts_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // sending this event at the top of the build so that whenever the user returns to the page a new request is sent
    // displaying any changes that may've been made / new completed workouts, instead of just when the app started up
    BlocProvider.of<WorkoutTableOperationsBloc>(context)
        .add(QueryAllWorkoutTableEvent());
    // TODO: this doesn't work for some reason
    BlocProvider.of<OpenExerciseModalCubit>(context).closeExerciseModal();
    return MultiBlocListener(
      listeners: homePageStateListeners(context),
      child: Scaffold(
        appBar: const TheAppBar(
          hasBackButton: false,
        ),
        backgroundColor: Colors.grey,
        body: Stack(children: [
          BlocBuilder<WorkoutTableOperationsBloc, WorkoutTableOperationsState>(
              builder: (context, state) {
            switch (state) {
              case WorkoutTableSuccessfulQueryAllState():
                return WorkoutsList(allWorkouts: state.allWorkoutsQuery);
              case WorkoutTableQueryErrorState():
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "There was an error querying the Workout table..",
                      textScaleFactor: 1.25,
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<WorkoutTableOperationsBloc>(context)
                              .add(QueryAllWorkoutTableEvent());
                        },
                        child: const Text("Re-fetch the workouts"))
                  ],
                ));
              default:
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fetching workouts..",
                        textScaleFactor: 1.25,
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                );
            }
          }),
          BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
              builder: (context, state) {
            return Align(
              alignment: const Alignment(0, 0.6),
              child: AnimatedOpacity(
                  opacity: state is NewActiveWorkoutState ? 1 : 0,
                  duration: const Duration(seconds: 5),
                  child: state is NewActiveWorkoutState
                      ? const ContinueWorkoutButton()
                      : const SizedBox()),
            );
          }),
          Container(
              alignment: const Alignment(0, 0.8),
              child: const NewWorkoutButton()),
        ]),
        // FOR DEBUG
        floatingActionButton: false
            ? const LoadErroredWorkoutButton(loadFromAssetDebug: true,)
            : false
                ? const DebugStateChecker()
                : null,
      ),
    );
  }

  List<BlocListener> homePageStateListeners(
      BuildContext context) {
    return [
      BlocListener<BackupCurrentWorkoutCubit, BackupCurrentWorkoutState>(
          listener: (context, state) {
        if (state.backupWorkoutData.isNotEmpty) {
          BlocProvider.of<ActiveWorkoutCubit>(context)
              .loadSavedJsonWorkoutToState(state.backupWorkoutData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                child: Text(
                  'Resuming the backed up workout',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              backgroundColor: Colors.blue,
            ),
          );
          Navigator.of(context).pushNamed("/workout-page");
        }
      }),
      // The following Listeners are to catch state changes that happen
      // before being routed to the workout page
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
