import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';

class ButtonRowWidget extends StatelessWidget {
  const ButtonRowWidget(
      {super.key,
      required this.newMovementName,
      required this.workedMuscleGroups});

  final String? newMovementName;
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CancelAddNewMovementButton(),
          AcceptAddNewMovementButton(
              newMovementName: newMovementName,
              workedMuscleGroups: workedMuscleGroups)
        ],
      ),
    );
  }
}

class AcceptAddNewMovementButton extends StatelessWidget {
  const AcceptAddNewMovementButton(
      {super.key,
      required this.newMovementName,
      required this.workedMuscleGroups});

  final String? newMovementName;
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      disabledColor: Colors.black.withOpacity(0),
      onPressed: newMovementName != null
          ? () {
              if (workedMuscleGroups.returnPrimaryMuscleGroups().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Center(
                      child: Text(
                        'Error: A minimum of 1 primary muscle group must be selected to create a new movement',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                BlocProvider.of<AddExerciseCubit>(context)
                    .addNewMovement(newMovementName!, workedMuscleGroups);
                BlocProvider.of<AddNewMovementCubit>(context)
                    .closeAddNewMovementExpansionPanel();
              }
            }
          : null,
      icon: const Icon(Icons.check_circle_outline, size: 40),
    );
  }
}

class CancelAddNewMovementButton extends StatelessWidget {
  const CancelAddNewMovementButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => BlocProvider.of<AddNewMovementCubit>(context)
            .closeAddNewMovementExpansionPanel(),
        icon: const Icon(
          Icons.cancel_outlined,
          size: 40,
        ));
  }
}
