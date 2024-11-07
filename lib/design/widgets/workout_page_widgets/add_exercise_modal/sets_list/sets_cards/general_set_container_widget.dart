import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_state.dart';

import 'duration_text_field_widget.dart';
import 'set_numerical_fields_widget.dart';
import 'warm_up_check_box.dart';

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
    if (currentSet != null) return SetType.current;
    if (comparisonSet != null) return SetType.comparison;
    if (completedSet != null) return SetType.completed;
    throw ArgumentError(
        'The set container needs either a current set, completed set or comparison set');
  }

  dynamic get set {
    if (currentSet != null) return currentSet;
    if (comparisonSet != null) return comparisonSet;
    if (completedSet != null) return completedSet;
    throw ArgumentError(
        'The set container needs either a current set, completed set or comparison set');
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
                  WorkingSetCount(setNumber: setNumber),
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
                updateDisplay: false,
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
              if (false)
                Expanded(
                    child: _buildField(
                  label: "Effort",
                  value: null,
                  setType: setType,
                )),
            ],
          ),
          ExpandableNotesTextField(
            headerTextStyle: headerTextStyle,
            setType: setType,
            notes: set.notes,
          ),
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
      "Effort": TextFieldType.text,
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
          SetNumericalField(
            value: value,
            setType: setType,
            updateField: updateDisplay,
            inputType: textFieldTypeMap[label] == TextFieldType.number
                ? TextInputType.number
                : TextInputType.text,
            updateSetFunction: updateSetFunction,
          )
      ],
    );
  }
}

class FinishSetButton extends StatelessWidget {
  const FinishSetButton({
    super.key,
    required this.currentSet,
  });

  final CurrentSet? currentSet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: SizedBox(
        width: 20,
        height: 20,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: currentSet!.weight != null && currentSet!.reps != null
              ? () {
                  BlocProvider.of<SetTimerCubit>(context).stopTimer();
                  BlocProvider.of<AddExerciseCubit>(context).updateCurrentSet(
                      CurrentSet(
                          setDuration: BlocProvider.of<SetTimerCubit>(context)
                              .returnTimed()));
                  BlocProvider.of<AddExerciseCubit>(context).saveCompletedSet();
                  BlocProvider.of<SetTimerCubit>(context).resetTimer();
                }
              : null,
          disabledColor: Colors.black.withOpacity(0),
          color: const Color.fromRGBO(0, 200, 0, 1),
          icon: const Icon(
            Icons.check,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class WorkingSetCount extends StatelessWidget {
  const WorkingSetCount({
    super.key,
    required this.setNumber,
  });

  final int? setNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
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
      ],
    );
  }
}

class ExpandableNotesTextField extends StatefulWidget {
  final TextStyle headerTextStyle;
  final SetType setType;
  final String? notes;

  const ExpandableNotesTextField({
    super.key,
    required this.headerTextStyle,
    required this.setType,
    required this.notes,
  });

  @override
  State<ExpandableNotesTextField> createState() =>
      _ExpandableNotesTextFieldState();
}

class _ExpandableNotesTextFieldState extends State<ExpandableNotesTextField> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  bool showIcon() => widget.setType == SetType.current || widget.notes != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1, color: Colors.black.withOpacity(0.1)))),
          height: 24,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("Notes..", style: widget.headerTextStyle),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: showIcon()
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: _toggleExpanded,
                          icon: Icon(
                            _isExpanded
                                ? Icons.arrow_drop_down
                                : Icons.arrow_right,
                            color: widget.setType == SetType.completed
                                ? Colors.black
                                : Colors.white,
                            size: 15,
                          ),
                        )
                      : Container()),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          height: _isExpanded ? 50 : 0,
          // Adjust height for expanded/collapsed states
          child: _isExpanded
              ? SetNumericalField(
                  value: widget.notes,
                  setType: widget.setType,
                  inputType: TextInputType.text,
                  updateSetFunction: (notes) {
                    BlocProvider.of<AddExerciseCubit>(context)
                        .updateCurrentSet(CurrentSet(notes: notes));
                  },
                )
              : null,
        ),
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
