import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';

import 'current_set_fields_widget.dart';

class CurrentSetCard extends StatelessWidget {
  final CurrentSet? currentSet;
  final GeneralExerciseSetModel? comparisonSet;
  final fieldText = TextEditingController();

  CurrentSetCard({super.key, this.currentSet, this.comparisonSet});

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
              currentValue: currentSet!.isWarmUp,
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(isWarmUp: value));
              },
              controller_: fieldText,
            ),
            CurrentSetFields(
              fieldName: "Weight",
                currentValue: currentSet!.weight,
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(weight: value));
              },
              controller_: fieldText,
              isBetter: comparisonSet == null
                  ? null
                  : currentSet == null
                      ? null
                      : currentSet!.weight == null
                          ? null
                          : comparisonSet!.weight == currentSet!.weight!
                              ? null
                              : comparisonSet!.weight < currentSet!.weight!,
            ),
            CurrentSetFields(
              fieldName: "Reps",
                currentValue: currentSet!.reps,
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(reps: value));
              },
              controller_: fieldText,
              isBetter: comparisonSet == null
                  ? null
                  : currentSet == null
                      ? null
                      : currentSet!.weight != null &&
                              currentSet!.weight! > comparisonSet!.weight
                          ? null
                          : currentSet!.reps == null
                              ? null
                              : comparisonSet!.reps == currentSet!.reps!
                                  ? null
                                  : comparisonSet!.reps < currentSet!.reps!,
            ),
            CurrentSetFields(
              fieldName: "Extra Reps",
                currentValue: currentSet!.extraReps,
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context)
                    .updateCurrentSet(CurrentSet(extraReps: value));
              },
              controller_: fieldText,
              isBetter: comparisonSet == null
                  ? null
                  : currentSet == null
                      ? null
                      : currentSet!.weight != null &&
                              currentSet!.weight! > comparisonSet!.weight
                          ? null
                          : currentSet!.extraReps == null
                              ? null
                              : comparisonSet!.extraReps == null &&
                                      currentSet!.extraReps != null
                                  ? true
                                  : comparisonSet!.extraReps! ==
                                          currentSet!.extraReps!
                                      ? null
                                      : comparisonSet!.extraReps! <
                                          currentSet!.extraReps!,
            ),
            const TimerSetField(),
            CurrentSetFields(
              fieldName: "Notes",
                currentValue: currentSet!.notes,
              updateSetFunction: (value) {
                BlocProvider.of<AddExerciseCubit>(context).updateCurrentSet(
                    CurrentSet(
                        notes: (value as String).replaceAll("\"", "\'")));
              },
              controller_: fieldText,
            ),
            IconButton(
                onPressed: currentSet != null &&
                        currentSet!.weight != null &&
                        currentSet!.reps != null
                    ? () {
                        BlocProvider.of<SetTimerCubit>(context).stopTimer();
                        BlocProvider.of<AddExerciseCubit>(context)
                            .updateCurrentSet(CurrentSet(
                                setDuration:
                                    BlocProvider.of<SetTimerCubit>(context)
                                        .returnTimed()));
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
