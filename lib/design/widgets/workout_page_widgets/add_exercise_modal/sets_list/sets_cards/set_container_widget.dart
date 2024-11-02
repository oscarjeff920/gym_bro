import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import 'duration_text_field_widget.dart';
import 'warm_up_check_box.dart';

class SetContainer extends StatelessWidget {
  // final bool isPrevious;
  // final bool isCompleted;
  final GeneralExerciseSetModel? completedSet;
  final CurrentSet? currentSet;
  final GeneralExerciseSetModel? comparisonSet;
  final int? setNumber;

  const SetContainer({
    super.key,
    // this.isPrevious = false,
    // this.isCompleted = false,
    this.completedSet,
    this.currentSet,
    this.comparisonSet,
    this.setNumber,
  });

  static const textStyle = TextStyle(fontSize: 9, color: Colors.white);

  bool get isCurrent => currentSet != null;

  bool get isPrevious => comparisonSet != null && currentSet == null;

  bool get isCompleted => completedSet != null;

  GeneralExerciseSetModel? get set =>
      isCurrent ? null : isPrevious ? comparisonSet : completedSet;

  Color get setColour {
    if (isPrevious) {
      return const Color.fromRGBO(0, 0, 0, 1);
    } else if (isCurrent) {
      return const Color.fromRGBO(124, 124, 124, 1);
    } else {
      return const Color.fromRGBO(255, 255, 255, 0.9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      color: setColour,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isCompleted)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    setNumber == null ? "Warm up Set" : "Working Set: ",
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.6),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    setNumber == null ? "" : "$setNumber",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 11,
                    ),
                  ),
                  const Spacer(),
                  if (isCurrent)
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check,
                                size: 20,
                              ))),
                    )
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [SetFieldHeader(header: "Rest Time:"), DurationTextFieldWidget()],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SetFieldHeader(header: "Warm Up:"),
                    WarmupCheckbox(
                      isBoxChecked: isCurrent
                          ? currentSet!.isWarmUp!
                          : set!.isWarmUp,
                      updateSetFunction: (value) {
                        BlocProvider.of<AddExerciseCubit>(context)
                            .updateCurrentSet(CurrentSet(isWarmUp: value));
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [SetFieldHeader(header: "Weight:"), TextField()],
                ),
              ),
              Expanded(
                child: Column(
                  children: [SetFieldHeader(header: "Reps:"), TextField()],
                ),
              ),
              Expanded(
                child: Column(
                  children: [SetFieldHeader(header: "+ Reps:"), TextField()],
                ),
              ),
              // Expanded(
              //   child: Column(
              //     children: [SetFieldHeader(header: "Duration:"), DurationTextFieldWidget(displayDuration: ,)],
              //   ),
              // ),
              Expanded(
                child: Column(
                  children: [
                    SetFieldHeader(header: "Effort:"),
                    TextField(readOnly: true)
                  ],
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                  child: Stack(
                    children: [
                      const Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: SetFieldHeader(header: "Notes.."))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          // iconSize: 15,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SetFieldHeader extends StatelessWidget {
  final String header;

  const SetFieldHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Text(
      header.toString(),
      // textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 9,
        color: Colors.white,
      ),
    );
  }
}
