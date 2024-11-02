import 'package:flutter/material.dart';

class WarmupCheckbox extends StatefulWidget {
  final Function(dynamic)? updateSetFunction;
  final bool isBoxChecked;
  final bool isCompleted;

  bool get isReadOnly => updateSetFunction == null;

  const WarmupCheckbox(
      {super.key, required this.updateSetFunction, required this.isBoxChecked, this.isCompleted = false});

  @override
  State<WarmupCheckbox> createState() => _WarmupCheckboxState();
}

class _WarmupCheckboxState extends State<WarmupCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: widget.isBoxChecked,
        checkColor: widget.isCompleted ? Colors.white : Colors.black,
        fillColor: WidgetStatePropertyAll<Color>(widget.isCompleted ? Colors.white : Colors.black.withOpacity(0)),
        onChanged: widget.isReadOnly ? null : (bool? value) {
          setState(() {
            widget.updateSetFunction!(value);
          });
        });
  }
}
