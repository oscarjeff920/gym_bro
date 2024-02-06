import 'package:flutter/material.dart';
import 'exercise_tile_base_widget.dart';

class AddNewExerciseTile extends StatelessWidget {
  final double tileSpacingValue;
  const AddNewExerciseTile({super.key, required this.tileSpacingValue});

  @override
  Widget build(BuildContext context) {
    return ExerciseTileBase(
      tileColour: const Color(0xff747474),
      centerWidget: const Icon(Icons.add, color: Colors.white, size: 50,),
      clickBehaviour: () {print("it clicked....");},
      isTop: true,
        tileSpacingValue: tileSpacingValue//BlocProvider.of<AddExerciseCubit>(context).openModal();},
    );
  }
}
