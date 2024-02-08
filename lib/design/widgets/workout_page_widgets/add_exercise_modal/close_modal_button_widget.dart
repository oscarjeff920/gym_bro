import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';

class CloseModalButton extends StatelessWidget {
  const CloseModalButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        alignment: Alignment.bottomRight,
        onPressed: () {
          BlocProvider.of<OpenExerciseModalCubit>(context)
              .closeExerciseModal();
        },
        icon: const Icon(Icons.check_circle));
  }
}