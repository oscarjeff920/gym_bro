import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

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
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(10, 10, 10, 0.6),
        ),
      ),
    );
  }
}

class MuscleGroupIndicatorRowWidget extends StatelessWidget {
  final bool isPrimary;

  const MuscleGroupIndicatorRowWidget({super.key, required this.isPrimary});

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

class RaisedMuscleGroupButton extends StatefulWidget {
  final MuscleGroup muscleGroup;
  final bool isPrimary;

  const RaisedMuscleGroupButton(
      {super.key, required this.muscleGroup, required this.isPrimary});

  @override
  State<RaisedMuscleGroupButton> createState() =>
      _RaisedMuscleGroupButtonState();
}

class _RaisedMuscleGroupButtonState extends State<RaisedMuscleGroupButton> {
  bool _isToggled = false;

  void _toggleButton() {
    setState(() {
      _isToggled = !_isToggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: () {
            _toggleButton();
          },
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
            shape: widget.isPrimary
                ? WidgetStateProperty.all(const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.zero, // No border radius for square shape
                  ))
                : null,
            elevation: _isToggled
                ? const WidgetStatePropertyAll(0)
                : const WidgetStatePropertyAll(3),
            backgroundColor: _isToggled
                ? WidgetStatePropertyAll(widget.muscleGroup.colour)
                : const WidgetStatePropertyAll(Color.fromRGBO(255, 255, 255, 0.75)),
          ),
          child: Icon(
            widget.muscleGroup.icon,
            color: Colors.black,
            size: widget.isPrimary ? 30 : 20
          ),
        ),
      ),
    );
  }
}
