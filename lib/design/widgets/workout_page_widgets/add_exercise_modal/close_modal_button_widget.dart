import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

class CloseModalButton extends StatelessWidget {
  final bool isFinished;

  const CloseModalButton({
    super.key, required this.isFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          new BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
          onPressed: () {
            BlocProvider.of<OpenExerciseModalCubit>(context)
                .closeExerciseModal();
          },
          icon: Icon(
            isFinished ? Icons.check_circle : Icons.cancel,
            size: 35,
          )),
    );
  }
}
