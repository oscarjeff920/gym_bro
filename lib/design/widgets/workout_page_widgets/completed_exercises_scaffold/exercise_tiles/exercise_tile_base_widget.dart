import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

class ExerciseTileBase extends StatelessWidget {
  final Color tileColour;
  final Widget centerWidget;
  final Function clickBehaviour;

  final bool isTop;

  final double tileSpacingValue;

  const ExerciseTileBase({
    super.key,
    required this.tileColour,
    required this.centerWidget,
    required this.clickBehaviour,
    this.isTop = false,
    required this.tileSpacingValue,
  });

  @override
  Widget build(BuildContext context) {
    // COMBINE-SPACING!
    double paddingValue = tileSpacingValue;
    EdgeInsets usedPadding() {
      if (isTop == false) {
        return EdgeInsets.only(bottom: paddingValue);
      } else {
        return EdgeInsets.symmetric(vertical: paddingValue);
      }
    }

    return Padding(
      padding: usedPadding(),
      child: GestureDetector(
          onTap: () {
            BlocProvider.of<OpenExerciseModalCubit>(context)
                .openExerciseModal();
          }, //,//clickBehaviour(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: tileColour,
              child: Center(child: centerWidget),
            ),
          )),
    );
  }
}
