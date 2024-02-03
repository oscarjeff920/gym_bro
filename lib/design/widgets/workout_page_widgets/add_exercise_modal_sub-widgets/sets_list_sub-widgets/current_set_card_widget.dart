import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/database/data_models.dart';

import '../../../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'current_set_card_sub-widgets/current_set_fields_widget.dart';

class CurrentSetCard extends StatelessWidget {
  final CurrentSet? currentSet;

  const CurrentSetCard({
    super.key,
    this.currentSet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: Row(
        children: [
          CurrentSetFields(
            fieldName: "Weight",
            updateSetFunction: (value) {
              BlocProvider.of<AddExerciseCubit>(context)
                  .updateCurrentSet(CurrentSet(weight: value));
            },
          ),
          CurrentSetFields(
            fieldName: "Reps",
            updateSetFunction: (value) {
              BlocProvider.of<AddExerciseCubit>(context)
                  .updateCurrentSet(CurrentSet(reps: value));
            },
          ),
          CurrentSetFields(
            fieldName: "Warm Up",
            isCheckBox: true,
            updateSetFunction: (value) {
              BlocProvider.of<AddExerciseCubit>(context)
                  .updateCurrentSet(CurrentSet(isWarmUp: value));
            },
          ),
          CurrentSetFields(
            fieldName: "Notes",
            updateSetFunction: (value) {
              BlocProvider.of<AddExerciseCubit>(context)
                  .updateCurrentSet(CurrentSet(notes: value));
            },
          ),
          IconButton(
              onPressed: currentSet != null &&
                      currentSet!.weight != null &&
                      currentSet!.reps != null &&
                      currentSet!.isWarmUp != null
                  ? BlocProvider.of<AddExerciseCubit>(context)
                      .saveCompletedSet()
                  : null,
              disabledColor: Colors.pink.withOpacity(0),
              color: Colors.black,
              icon: const Icon(
                Icons.done,
              ))
        ],
      ),
    );
  }
}
