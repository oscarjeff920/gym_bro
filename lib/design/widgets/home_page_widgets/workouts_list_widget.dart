import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';

class WorkoutsList extends StatelessWidget {
  final List<WorkoutTable> allWorkouts;

  const WorkoutsList({super.key, required this.allWorkouts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: allWorkouts.length,
      itemBuilder: (BuildContext context, int index) {
        return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
          builder: (context, state) {
            return ListTile(
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        "${allWorkouts[index].day}/${allWorkouts[index].month}/${allWorkouts[index].year}"),
                    Text(allWorkouts[index].workoutStartTime ?? "- - -")
                  ],
                ),
              ),
              tileColor: Colors.white,
              onTap: () {
                // if the selected workout has already been loaded to state
                // we can just move onto the workout page, no need to re-query
                if (state is LoadedActiveWorkoutState &&
                    state.id == allWorkouts[index].id) {
                  Navigator.of(context).pushNamed("/workout-page");
                } else {
                  // query selected workout and load it to ActiveWorkoutState
                  BlocProvider.of<ExerciseTableOperationsBloc>(context).add(
                      QueryAllExerciseByWorkoutEvent(
                          selectedWorkout: allWorkouts[index]));
                  BlocProvider.of<ActiveWorkoutCubit>(context)
                      .loadWorkoutToState(allWorkouts[index]);
                }
              },
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 12,
        );
      },
    );
  }
}
