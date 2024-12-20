import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_event.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';

class MuscleGroupButton extends StatelessWidget {
  const MuscleGroupButton({super.key, required this.muscleGroup});

  final MuscleGroup muscleGroup;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<AddExerciseCubit>(context)
            .selectMuscleGroup(muscleGroup);
        BlocProvider.of<AddNewMovementCubit>(context)
            .addSelectedMuscleGroupToWorkedMuscleGroups(muscleGroup);
        BlocProvider.of<MovementByMuscleGroupBloc>(context).add(
            QueryMovementByPrimaryMuscleEvent(
                selectedMuscleGroup: muscleGroup.type));
        BlocProvider.of<GetLastExerciseSetsByMovementBloc>(context)
            .add(ResetGetLastExerciseSetsByMovementEvent());
      },
      icon: Icon(
        muscleGroup.icon,
        size: 40,
        color: muscleGroup.colour,
      ),
    );
  }
}
