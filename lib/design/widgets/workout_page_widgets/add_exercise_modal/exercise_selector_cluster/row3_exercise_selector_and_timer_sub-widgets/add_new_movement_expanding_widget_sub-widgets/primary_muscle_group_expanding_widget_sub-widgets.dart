import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class PrimaryMuscleGroupHeaderWidget extends StatelessWidget {
  const PrimaryMuscleGroupHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Text(
        "Primary Muscle Group:",
        style: TextStyle(
          fontSize: 10,
          color: Color.fromRGBO(10, 10, 10, 0.6),
        ),
      ),
    );
  }
}

class PrimaryMuscleGroupIndicatorRowWidget extends StatelessWidget {
  const PrimaryMuscleGroupIndicatorRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: BlocBuilder<AddExerciseCubit, AddExerciseState>(
          builder: (context, state) {
            return TextField(
              decoration: const InputDecoration(
                  prefix: SizedBox(
                    width: 10,
                  )),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              controller: TextEditingController()
                ..text = state.muscleGroupToString() ?? "",
              readOnly: true,
            );
          },
        ));
  }
}

