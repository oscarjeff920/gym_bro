import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';

class WorkoutsList extends StatelessWidget {
  final List<WorkoutTable> allWorkouts;

  const WorkoutsList({super.key, required this.allWorkouts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: allWorkouts.length,
      itemBuilder: (BuildContext context, int index) {
        return BlocListener<ExerciseTableOperationsBloc,
            ExerciseTableOperationsState>(
          listener: (context, state) {
            switch (state) {
              case ExerciseTableSuccessfulQueryAllByWorkoutIdState():
                print(
                    "====> WorkoutPage in ExerciseTableSuccessfulQueryAllByWorkoutIdState LN#30");
                BlocProvider.of<ActiveWorkoutCubit>(context)
                    .loadExercisesToState(state.selectedWorkout);
            }
          },
          child: ListTile(
            title: Center(
              child: Text(
                  "${allWorkouts[index].day}/${allWorkouts[index].month}/${allWorkouts[index].year}"),
            ),
            tileColor: Colors.white,
            onTap: () {
              BlocProvider.of<ExerciseTableOperationsBloc>(context).add(
                  QueryAllExerciseByWorkoutEvent(
                      selectedWorkout: allWorkouts[index]));
              BlocProvider.of<ActiveWorkoutCubit>(context)
                  .loadWorkoutToState(allWorkouts[index]);
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 12,
        );
      },
    );
  }
}
