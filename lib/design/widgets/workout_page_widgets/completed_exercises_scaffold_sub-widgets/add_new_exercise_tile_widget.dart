import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'exercise_tile_base_widget.dart';

class AddNewExerciseTile extends StatelessWidget {
  const AddNewExerciseTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExerciseTileBase(
      tileColour: const Color(0xff747474),
      centerWidget: const Icon(Icons.add, color: Colors.white, size: 50,),
      clickBehaviour: () {print("it clicked....");},//BlocProvider.of<AddExerciseCubit>(context).openModal();},
    );
  }
}
