import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/FE_consts/enums.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/movement_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/movement_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

class MuscleGroupButton extends StatelessWidget {
  const MuscleGroupButton({super.key, required this.muscleGroup});

  final MuscleGroupType muscleGroup;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<AddExerciseCubit>(context)
            .selectMuscleGroup(muscleGroup);
        BlocProvider.of<MovementTableOperationsBloc>(context).add(
            QueryMovementByPrimaryMuscleEvent(selectedMuscleGroup: muscleGroup));
      },
      icon: Icon(
        assignIcon(muscleGroup),
        size: 40,
        color: muscleGroupColours[muscleGroup],
      ),
    );
  }
}
