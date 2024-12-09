import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';

class MuscleGroupHeaderWidget extends StatelessWidget {
  final bool isPrimary;

  const MuscleGroupHeaderWidget({super.key, required this.isPrimary});

  get muscleRole => isPrimary ? 'Primary' : 'Secondary';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        "$muscleRole Muscle Group(s):",
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(10, 10, 10, 0.6),
        ),
      ),
    );
  }
}

class MuscleGroupIndicatorRowWidget extends StatelessWidget {
  final bool isPrimary;
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  const MuscleGroupIndicatorRowWidget(
      {super.key, required this.isPrimary, required this.workedMuscleGroups});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExerciseCubit, AddExerciseState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var muscleGroup in MuscleGroup.allMuscleGroups.values)
              Expanded(
                child: RaisedMuscleGroupButton(
                  workedMuscleGroups: workedMuscleGroups,
                  muscleGroup: muscleGroup,
                  isPrimary: isPrimary,
                ),
              ),
          ],
        );
      },
    );
  }
}

class RaisedMuscleGroupButton extends StatelessWidget {
  final MovementWorkedMuscleGroupsType workedMuscleGroups;
  final MuscleGroup muscleGroup;
  final bool isPrimary;

  const RaisedMuscleGroupButton(
      {super.key,
      required this.workedMuscleGroups,
      required this.muscleGroup,
      required this.isPrimary});

  bool get _isToggled {
    RoleType movementRole = isPrimary ? RoleType.primary : RoleType.secondary;
    return workedMuscleGroups.isMuscleGroupWorkedWithRole(
        muscleGroup.type, movementRole);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: () => BlocProvider.of<AddNewMovementCubit>(context)
              .updateWorkedMuscleGroups(
                  isPrimary: isPrimary,
                  muscleGroup: muscleGroup.type,
                  toggleOn: !_isToggled),
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
            shape: isPrimary
                ? WidgetStateProperty.all(const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.zero, // No border radius for square shape
                  ))
                : null,
            elevation: _isToggled
                ? const WidgetStatePropertyAll(0)
                : const WidgetStatePropertyAll(3),
            backgroundColor: _isToggled
                ? WidgetStatePropertyAll(muscleGroup.colour)
                : const WidgetStatePropertyAll(
                    Color.fromRGBO(255, 255, 255, 0.75)),
          ),
          child: Icon(muscleGroup.icon,
              color: Colors.black, size: isPrimary ? 30 : 20),
        ),
      ),
    );
  }
}
