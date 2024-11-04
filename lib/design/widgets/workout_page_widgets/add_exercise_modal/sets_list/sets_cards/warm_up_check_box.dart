import 'package:flutter/material.dart';

import 'general_set_container_widget.dart';

class WarmupCheckbox extends StatefulWidget {
  final bool isBoxChecked;
  final Function(dynamic)? updateSetFunction;
  final SetType setType;
  final bool isCompleted;

  bool get isReadOnly => updateSetFunction == null;

  Color get checkColour =>
      setType == SetType.completed ? Colors.black : Colors.white;

  const WarmupCheckbox(
      {super.key,
      required this.isBoxChecked,
      this.updateSetFunction,
      this.isCompleted = false,
      required this.setType});

  @override
  State<WarmupCheckbox> createState() => _WarmupCheckboxState();
}

class _WarmupCheckboxState extends State<WarmupCheckbox> {
  late bool isReadOnly = widget.setType == SetType.current ? false : true;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: widget.isBoxChecked,
        checkColor: widget.checkColour,
        fillColor: WidgetStatePropertyAll<Color>(
            widget.isCompleted ? Colors.white : Colors.black.withOpacity(0)),
        onChanged: widget.setType == SetType.current
            ? (bool? value) {
                setState(() {
                  widget.updateSetFunction!(value);
                });
              }
            : null);
  }
}
