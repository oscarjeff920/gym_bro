import 'package:flutter/material.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/general_set_container_widget.dart';

class SetNumericalField extends StatefulWidget {
  final dynamic value;
  final Function(dynamic)? updateSetFunction;
  final bool updateField;
  final SetType setType;
  final TextInputType inputType;

  const SetNumericalField(
      {super.key,
      required this.value,
      this.updateSetFunction,
      required this.setType,
      required this.inputType,
      this.updateField = true});

  Color get activeColour =>
      setType == SetType.completed ? Colors.black : Colors.white;

  @override
  State<SetNumericalField> createState() => _SetNumericalFieldState();
}

class _SetNumericalFieldState extends State<SetNumericalField> {
  late bool isReadOnly = widget.setType == SetType.current ? false : true;
  late final TextEditingController _controller;

  TextEditingController setController() {
    // If the field is a double, set updateField to false.
    // This is necessary because when a double is converted to a string,
    // it automatically includes a decimal (e.g., 1 becomes "1.0").
    // If the field is updated, the cursor will be placed after the decimal
    // point, which could cause confusion. By not updating the display,
    // the field will only show the value that was explicitly entered,
    // preserving the user's input as-is.
    if (widget.updateField) {
      return _controller
        ..text = widget.value == null ? "" : widget.value.toString();
    }
    return _controller;
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.value == null ? "" : widget.value.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: widget.activeColour),
      decoration: const InputDecoration(border: InputBorder.none),
      controller: setController(),
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
