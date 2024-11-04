import 'package:flutter/material.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/general_set_container_widget.dart';

class SetNumericalField extends StatefulWidget {
  final dynamic value;
  final Function(dynamic)? updateSetFunction;
  final SetType setType;
  final TextInputType inputType;

  const SetNumericalField(
      {super.key,
      required this.value,
      this.updateSetFunction,
      required this.setType,
      required this.inputType});

  Color get activeColour =>
      setType == SetType.completed ? Colors.black : Colors.white;

  @override
  State<SetNumericalField> createState() => _SetNumericalFieldState();
}

class _SetNumericalFieldState extends State<SetNumericalField> {
  late bool isReadOnly = widget.setType == SetType.current ? false : true;

  // _makeEditable() {
  //   isReadOnly = true;
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: widget.activeColour),
      decoration: const InputDecoration(border: InputBorder.none),
      controller: TextEditingController()
        ..text = widget.value == null ? "" : widget.value.toString(),
      keyboardType: widget.inputType,
      textAlign: TextAlign.center,
      onChanged: (String inputtedValue) {
        if (widget.updateSetFunction != null) {
          widget.updateSetFunction!(inputtedValue);
        }
      },
      readOnly: isReadOnly,
    );
  }
}
