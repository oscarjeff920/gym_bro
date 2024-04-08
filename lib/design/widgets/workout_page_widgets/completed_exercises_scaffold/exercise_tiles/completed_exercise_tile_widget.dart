import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

import 'exercise_tile_base_widget.dart';

class CompletedExerciseTile extends StatelessWidget {
  final Color primaryMuscleGroupColour;
  final GeneralExerciseModel exercise;
  final int tileIndex;

  final double tileSpacingValue;

  const CompletedExerciseTile(
      {super.key,
      required this.primaryMuscleGroupColour,
      required this.tileIndex,
      required this.tileSpacingValue,
      required this.exercise});

  @override
  Widget build(BuildContext context) {
    bool loaded = exercise.exerciseSets.isNotEmpty;
    return ExerciseTileBase(
      tileColour: loaded ? primaryMuscleGroupColour : Colors.black12,
      centerWidget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 2,
                child: Text(capitalizeString(exercise.movementName),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center)),
            Text("Working Sets: ${exercise.numWorkingSets.toString()}"),
            Text("Exercise Duration: ${exercise.exerciseDuration}"),
          ],
        ),
      ),
      clickBehaviour: loaded
          ? () {
              BlocProvider.of<AddExerciseCubit>(context)
                  .addCompletedExercise(exercise);
              BlocProvider.of<OpenExerciseModalCubit>(context)
                  .openExerciseModal();
            }
          : null,
      isTop: tileIndex == 0 || tileIndex == 1 ? true : false,
      tileSpacingValue: tileSpacingValue,
    );
  }
}

String capitalizeString(String string) {
  String capitalizedString = "";
  List<String> stringSplit = string.split(" ");

  for (var string_ in stringSplit) {
    capitalizedString += "${string_[0].toUpperCase()}${string_.substring(1)} ";
  }

  return capitalizedString;
}
