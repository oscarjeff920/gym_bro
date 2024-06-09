import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class DebugStateChecker extends StatelessWidget {
  const DebugStateChecker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
      builder: (context, state) {
        ActiveWorkoutState activeWorkoutState_ = state;
        return BlocBuilder<ExerciseTableOperationsBloc,
            ExerciseTableOperationsState>(
          builder: (context, state) {
            ExerciseTableOperationsState exerciseTableState =
                state;
            return BlocBuilder<AddExerciseCubit,
                AddExerciseState>(
              builder: (context, state) {
                AddExerciseState addExerciseState_ = state;
                return FloatingActionButton(
                  child: const Icon(Icons.query_stats),
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
    );
  }
}