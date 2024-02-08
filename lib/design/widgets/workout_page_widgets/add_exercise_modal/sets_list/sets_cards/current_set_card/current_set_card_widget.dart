import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/FE_consts/flutter_data_models.dart';

import '../../../../../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import '../../../../../../../state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import '../../../../../../../state_management/cubits/set_timer_cubit/set_timer_state.dart';
import 'current_set_fields_widget.dart';

class CurrentSetCard extends StatelessWidget {
  final CurrentSet? currentSet;
  final fieldText = TextEditingController();

  CurrentSetCard({
    super.key,
    this.currentSet,
  });

  void clearText() {
    print("looks like we clearing");
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        color: Color(0xFF7C7C7C),
        child: Row(
          children: [
            CurrentSetFields(
              fieldName: "Warm Up",
              isCheckBox: true,
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(isWarmUp: value));
              }, controller_: fieldText,
            ),
            CurrentSetFields(
              fieldName: "Weight",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(weight: value));
              }, controller_: fieldText,
            ),
            CurrentSetFields(
              fieldName: "Reps",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(reps: value));
              }, controller_: fieldText,
            ),
            CurrentSetFields(
              fieldName: "Extra Reps",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(extraReps: value));
              }, controller_: fieldText,
            ),
            const TimerSetField(),
            CurrentSetFields(
              fieldName: "Notes",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(notes: value));
              }, controller_: fieldText,
            ),
            IconButton(
                onPressed: currentSet != null &&
                    currentSet!.weight != null &&
                    currentSet!.reps != null &&
                    currentSet!.isWarmUp != null
                    ? () {
                  BlocProvider.of<AddExerciseCubit>(context).saveCompletedSet();
                  BlocProvider.of<SetTimerCubit>(context).resetTimer();
                  clearText();
                }
                    : null,
                disabledColor: Colors.pink.withOpacity(0.5),
                color: Colors.black,
                icon: const Icon(
                  Icons.done,
                ))
          ],
        ),
      ),
    );
  }
}
