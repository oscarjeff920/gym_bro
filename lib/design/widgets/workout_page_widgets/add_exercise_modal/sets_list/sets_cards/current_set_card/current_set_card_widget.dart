import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';

import 'current_set_fields_widget.dart';

class CurrentSetCard extends StatelessWidget {
  final CurrentSet? currentSet;
  final Sets? currentPreviousSet;
  final fieldText = TextEditingController();

  CurrentSetCard({super.key, this.currentSet, this.currentPreviousSet});

  void clearText() {
    print("looks like we clearing");
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 5),
        color: const Color(0xFF7C7C7C),
        child: Row(
          children: [
            CurrentSetFields(
              fieldName: "Warm Up",
              isCheckBox: true,
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(isWarmUp: value));
              },
              controller_: fieldText,
            ),
            CurrentSetFields(
              fieldName: "Weight",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(weight: value));
              },
              controller_: fieldText,
              isBetter: currentPreviousSet == null
                  ? null
                  : currentSet == null
                      ? null
                      : currentSet!.weight == null
                          ? null
                          : currentPreviousSet!.weight == currentSet!.weight!
                              ? null
                              : currentPreviousSet!.weight <
                                  currentSet!.weight!,
            ),
            CurrentSetFields(
              fieldName: "Reps",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(reps: value));
              },
              controller_: fieldText,
              isBetter: currentPreviousSet == null
                  ? null
                  : currentSet == null
                      ? null
                      : currentSet!.weight != null &&
                              currentSet!.weight! > currentPreviousSet!.weight
                          ? null
                          : currentSet!.reps == null
                              ? null
                              : currentPreviousSet!.reps == currentSet!.reps!
                                  ? null
                                  : currentPreviousSet!.reps <
                                      currentSet!.reps!,
            ),
            CurrentSetFields(
              fieldName: "Extra Reps",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(extraReps: value));
              },
              controller_: fieldText,
              isBetter: currentPreviousSet == null
                  ? null
                  : currentSet == null
                      ? null
                      : currentSet!.weight != null &&
                              currentSet!.weight! > currentPreviousSet!.weight
                          ? null
                          : currentSet!.extraReps == null
                              ? null
                              : currentPreviousSet!.extraReps == null &&
                                      currentSet!.extraReps != null
                                  ? true
                                  : currentPreviousSet!.extraReps! ==
                                          currentSet!.extraReps!
                                      ? null
                                      : currentPreviousSet!.extraReps! <
                                          currentSet!.extraReps!,
            ),
            const TimerSetField(),
            CurrentSetFields(
              fieldName: "Notes",
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(notes: value));
              },
              controller_: fieldText,
            ),
            IconButton(
                onPressed: currentSet != null &&
                        currentSet!.weight != null &&
                        currentSet!.reps != null &&
                        currentSet!.isWarmUp != null
                    ? () {
                        BlocProvider.of<AddExerciseCubit>(context)
                            .saveCompletedSet();
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
