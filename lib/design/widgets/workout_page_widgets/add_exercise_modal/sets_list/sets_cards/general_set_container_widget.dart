import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_state.dart';

import 'finish_set_button_widget.dart';
import 'set_field_types/duration_text_field_widget.dart';
import 'set_field_types/notes_text_field_animated_container_widget.dart';
import 'set_field_types/general_set_field_widget.dart';
import 'set_field_types/warm_up_check_box.dart';
import 'working_warmup_set_header_counter_widget.dart';

// enums
enum SetType { comparison, current, completed }

enum TextFieldType { duration, text, number, bool }

Map<String, TextFieldType> textFieldTypeMap = {
  "Rest Time": TextFieldType.duration,
  "Warm Up": TextFieldType.number,
  "Weight": TextFieldType.number,
  "Reps": TextFieldType.number,
  "+ Reps": TextFieldType.number,
  "Duration": TextFieldType.duration,
  "Effort": TextFieldType.text,
  "Notes": TextFieldType.text,
};

class GeneralSetContainer extends StatelessWidget {
  final GeneralExerciseSetModel? comparisonSet;
  final CurrentSet? currentSet;
  final GeneralExerciseSetModel? completedSet;
  final int? setNumber;

  const GeneralSetContainer({
    super.key,
    this.comparisonSet,
    this.currentSet,
    this.completedSet,
    this.setNumber,
  });

  SetType get setType {
    if (currentSet != null) {
      return SetType.current;
    } else if (comparisonSet != null) {
      return SetType.comparison;
    } else if (completedSet != null) {
      return SetType.completed;
    } else {
      throw ArgumentError(
          'The set container needs either a current set, completed set or comparison set');
    }
  }

  dynamic get set {
    if (currentSet != null) {
      return currentSet;
    } else if (comparisonSet != null) {
      return comparisonSet;
    } else if (completedSet != null) {
      return completedSet;
    } else {
      throw ArgumentError(
          'The set container needs either a current set, completed set or comparison set');
    }
  }

  TextStyle get headerTextStyle {
    return TextStyle(
      fontSize: 9,
      color: setType == SetType.completed ? Colors.black : Colors.white,
    );
  }

  Color get setColour {
    switch (setType) {
      case SetType.completed:
        return const Color.fromRGBO(255, 255, 255, 0.9);
      case SetType.comparison:
        return const Color.fromRGBO(0, 0, 0, 1);
      case SetType.current:
      default:
        return const Color.fromRGBO(124, 124, 124, 1);
    }
  }

  double get notesContainerHeight => 28;

  double _calculateEffective1RM(double weight, int reps) {
    if (reps < 5) {
      // Brzycki Formula
      return weight / (1.0278 - (0.0278 * reps));
    } else {
      // Epley Formula
      return weight * (1 + (0.0333 * reps));
    }
  }

  String returnEffective1RM({required double weight, required int reps}) {
    double calculatedWeight = _calculateEffective1RM(weight, reps);
    return calculatedWeight.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1.5),
          color: setColour),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (setType != SetType.completed)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  WorkingSetCount(
                      setNumber: setNumber,
                      isCurrent: setType == SetType.current),
                  const Spacer(),
                  if (setType == SetType.current)
                    FinishSetButton(currentSet: currentSet),
                ],
              ),
            ),
          Row(
            children: [
              if (false)
                Expanded(
                    child: _buildField(
                  label: "Rest Time",
                  value: null,
                  setType: setType,
                )),
              Expanded(
                  child: _buildField(
                label: "Warm Up",
                value: set.isWarmUp,
                updateSetFunction: (newValue) {
                  BlocProvider.of<AddExerciseCubit>(context)
                      .updateCurrentSet(CurrentSet(isWarmUp: newValue));
                },
                setType: setType,
              )),
              Expanded(
                  child: _buildField(
                label: "Weight",
                value: set.weight,
                // The following field is required because weight is a double.
                // When a double is converted to a string, it includes a decimal (e.g., 1 becomes "1.0").
                // This can cause issues when entering a value: if you enter "1", it displays as "1.0"
                // with the cursor placed after the decimal point. To enter "11",
                // you'd need to manually move the cursor, which can be inconvenient.
                updateDisplay: setType == SetType.current ? false : true,
                updateSetFunction: (newValue) {
                  double weightValue = double.parse(newValue);
                  BlocProvider.of<AddExerciseCubit>(context)
                      .updateCurrentSet(CurrentSet(weight: weightValue));
                },
                setType: setType,
              )),
              Expanded(
                  child: _buildField(
                label: "Reps",
                value: set.reps,
                updateSetFunction: (newValue) {
                  int reps = int.parse(newValue);
                  BlocProvider.of<AddExerciseCubit>(context)
                      .updateCurrentSet(CurrentSet(reps: reps));
                },
                setType: setType,
              )),
              Expanded(
                  child: _buildField(
                label: "+ Reps",
                value: set.extraReps,
                updateSetFunction: (newValue) {
                  int extraReps = int.parse(newValue);
                  BlocProvider.of<AddExerciseCubit>(context)
                      .updateCurrentSet(CurrentSet(extraReps: extraReps));
                },
                setType: setType,
              )),
              Expanded(
                  child: setType == SetType.current
                      ? BlocBuilder<SetTimerCubit, SetTimerState>(
                          builder: (context, state) {
                            return _buildField(
                              label: "Duration",
                              value: state.toString(),
                              setType: setType,
                            );
                          },
                        )
                      : _buildField(
                          label: "Duration",
                          value: set.setDuration ?? "- - -",
                          setType: setType,
                        )),
              Expanded(
                  child: Container(
                color: !(set.weight == null || set.reps == null || set.weight == 0 || set.isWarmUp)
                    ? Colors.yellow.withOpacity(0.3)
                    : null,
                child: _buildField(
                  label: "Eff. 1RM",
                  value: !(set.weight == null || set.reps == null || set.weight == 0 || set.isWarmUp)
                      ? returnEffective1RM(weight: set.weight, reps: set.reps)
                      : "",
                  setType: setType,
                ),
              )),
            ],
          ),
          if (setType == SetType.current || set.notes != null)
            ExpandableNotesTextField(
              headerTextStyle: headerTextStyle,
              setType: setType,
              notes: set.notes,
              notesContainerHeight: notesContainerHeight,
            )
          else
            SizedBox(
              height: notesContainerHeight,
            )
        ],
      ),
    );
  }

  Widget _buildField(
      {required String label,
      required dynamic value,
      required SetType setType,
      bool updateDisplay = true,
      Function(dynamic)? updateSetFunction}) {
    Map<String, TextFieldType> textFieldTypeMap = {
      // "Warm up Set": TextFieldType.text,
      // "Working Set": TextFieldType.text,
      "Rest Time": TextFieldType.duration,
      "Warm Up": TextFieldType.bool,
      "Weight": TextFieldType.number,
      "Reps": TextFieldType.number,
      "+ Reps": TextFieldType.number,
      "Duration": TextFieldType.duration,
      "Eff. 1RM": TextFieldType.text,
      "Notes": TextFieldType.text,
    };

    return Column(
      children: [
        SetFieldHeader(header: "$label:", textStyle: headerTextStyle),
        if (textFieldTypeMap[label] == TextFieldType.duration)
          DurationTextFieldWidget(displayDuration: value, setType: setType)
        else if (textFieldTypeMap[label] == TextFieldType.bool)
          WarmupCheckbox(
            isBoxChecked: value,
            updateSetFunction: updateSetFunction,
            setType: setType,
          )
        else
          GeneralSetField(
            value: value,
            setType: setType,
            updateField: updateDisplay,
            autoFocus: label == "Weight" && value == null ? true : false,
            inputType: textFieldTypeMap[label] == TextFieldType.number
                ? TextInputType.number
                : TextInputType.text,
            updateSetFunction: updateSetFunction,
          )
      ],
    );
  }
}

class SetFieldHeader extends StatelessWidget {
  final String header;
  final TextStyle textStyle;

  const SetFieldHeader(
      {super.key, required this.header, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(header.toString(),
        // textAlign: TextAlign.center,
        style: textStyle);
  }
}
