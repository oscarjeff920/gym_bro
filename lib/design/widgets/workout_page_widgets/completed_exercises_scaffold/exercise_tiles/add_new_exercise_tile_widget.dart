import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';
import 'exercise_tile_base_widget.dart';

class AddNewExerciseTile extends StatelessWidget {
  final double tileSpacingValue;

  const AddNewExerciseTile({super.key, required this.tileSpacingValue});

  @override
  Widget build(BuildContext context) {
    return ExerciseTileBase(
        tileColour: const Color(0xff747474),
        centerWidget: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
        clickBehaviour: () {
          BlocProvider.of<OpenExerciseModalCubit>(context).openExerciseModal();
        },
        isTop: true,
        tileSpacingValue:
            tileSpacingValue //BlocProvider.of<AddExerciseCubit>(context).openModal();},
        );
  }
}
