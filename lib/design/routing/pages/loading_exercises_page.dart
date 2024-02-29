import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_cubit.dart';

class LoadingExercisesPage extends StatelessWidget {
  const LoadingExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseTableOperationsBloc,
        ExerciseTableOperationsState>(
      builder: (context, state) {
        switch (state) {
          case ExerciseTableSuccessfulQueryAllByWorkoutIdState():
            BlocProvider.of<WorkoutPageWorkoutCubit>(context)
                .loadExercisesToWorkout(
                    state.selectedWorkout, state.allExercisesQuery);
            Navigator.of(context).pushNamed("/workout-page");
          default:
            Navigator.of(context).pushNamed("/");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
