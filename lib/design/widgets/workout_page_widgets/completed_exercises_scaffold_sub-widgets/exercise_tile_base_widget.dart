import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

import '../../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

class ExerciseTileBase extends StatelessWidget {
  final Color tileColour;
  final Widget centerWidget;
  final Function clickBehaviour;

  const ExerciseTileBase({
    super.key,
    required this.tileColour,
    required this.centerWidget,
    required this.clickBehaviour,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<OpenExerciseModalCubit>(context).openExerciseModal();
      },//,//clickBehaviour(),
        child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: tileColour,
        child: Center(child: centerWidget),
      ),
    ));
  }
}
