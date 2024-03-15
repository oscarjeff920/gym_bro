import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/the_app_bar_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';

import '../../widgets/home_page_widgets/new_workout_button_widget.dart';
import '../../widgets/home_page_widgets/workouts_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // sending this event at the top of the build so that whenever the user returns to the page a new request is sent
    // displaying any changes that may've been made / new completed workouts, instead of just when the app started up
    BlocProvider.of<WorkoutTableOperationsBloc>(context)
        .add(QueryAllWorkoutTableEvent());

    return BlocListener<ExerciseTableOperationsBloc,
        ExerciseTableOperationsState>(
      listener: (listenContext, state) {
        switch (state) {
          case ExerciseTableSuccessfulQueryAllByWorkoutIdState():
            // Here we're adding the queried exercises into the workout on the ActiveWorkoutState
            BlocProvider.of<ActiveWorkoutCubit>(context)
                .loadExercisesToState(state.selectedWorkout);
            // As the result of the query we need to reset the query state
            BlocProvider.of<ExerciseTableOperationsBloc>(context)
                .add(ResetExerciseQueryEvent());

            // as we have the exercises we can start querying for the exercise sets for each exercise
            BlocProvider.of<ExerciseSetTableOperationsBloc>(context).add(
                QueryAllExerciseSetsByExerciseEvent(
                    selectedWorkout: state.selectedWorkout));

            // As we've loaded the exercises we can now move to the workout page
            Navigator.of(context).pushNamed("/workout-page");

          case ExerciseTableQueryErrorState():
            BlocProvider.of<ExerciseTableOperationsBloc>(context)
                .add(ResetExerciseQueryEvent());
          case ExerciseTableQueryState():
          default:
        }
      },
      listenWhen: (previousState, state) => previousState != state,
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
                    return WorkoutsList(
                        allWorkouts: state.allWorkoutsQuery);
                  case WorkoutTableQueryErrorState():
                    return const Center(child: Text(
                        "There was an error querying the Workout table.."));
                  default:
                    return const Center(
                        child: Text("Ooops.. something has gone ary"));
                }
              }),
          Container(
              alignment: const Alignment(0, 0.8),
              child: const NewWorkoutButton()),
        ]),
      ),
    );
  }
}
