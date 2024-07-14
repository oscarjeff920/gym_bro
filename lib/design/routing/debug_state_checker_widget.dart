import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_state.dart';
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
      builder: (_activeWorkoutContext, _activeWorkoutState) {
        ActiveWorkoutState activeWorkoutState_ = _activeWorkoutState;
        return BlocBuilder<ExerciseTableOperationsBloc,
            ExerciseTableOperationsState>(
          builder: (_exerciseTableOperationsContext,
              _exerciseTableOperationsState) {
            ExerciseTableOperationsState exerciseTableState =
                _exerciseTableOperationsState;
            return BlocBuilder<AddExerciseCubit,
                AddExerciseState>(
              builder: (_addExerciseContext, _addExerciseState) {
                AddExerciseState addExerciseState_ = _addExerciseState;
                return BlocBuilder<MovementGetNameByIdBloc, MovementGetNameByIdState>(
                  builder: (_movementGetNameByIdContext, _movementGetNameByIdState) {
                    return BlocBuilder<
                        GetLastExerciseSetsByMovementBloc,
                        GetLastExerciseSetsByMovementState>(
                      builder: (_getLastExerciseSetsByMovementContext,
                          _getLastExerciseSetsByMovementState) {
                        return FloatingActionButton(
                          child: const Icon(Icons.query_stats),
                          onPressed: () {
                            print("");
                            print(
                                "ActiveWorkoutState: $activeWorkoutState_\n"
                                    "ExerciseTableOperationsState: $exerciseTableState\n"
                                    "AddExerciseState: $addExerciseState_\n"
                                    "GetLastExerciseSetsByMovementState: $_getLastExerciseSetsByMovementState\n"
                                    "MovementGetNameByIdState: $_movementGetNameByIdState}");
                            print("");
                          },
                        );
                      },
                    );
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