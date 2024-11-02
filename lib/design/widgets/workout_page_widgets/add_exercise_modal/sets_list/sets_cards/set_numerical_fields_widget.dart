import 'package:flutter/material.dart';

class SetNumericalFields extends StatefulWidget {
  final dynamic value;
  final Function(dynamic)? updateSetFunction;
  final TextStyle textStyle;


  const SetNumericalFields({super.key, required this.value, this.updateSetFunction, this.textStyle = const TextStyle(color: Colors.white)});

  @override
  State<SetNumericalFields> createState() =>
      _SetNumericalFieldsState();
}

class _SetNumericalFieldsState extends State<SetNumericalFields> {
  // bool isReadOnly = widget.isReadOnly;

  // _makeEditable() {
  //   isReadOnly = true;
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: widget.textStyle,
      controller: TextEditingController()
        ..text = widget.value == null ? "" : widget.value.toString(),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: (String inputtedValue) {
        if (widget.updateSetFunction != null) widget.updateSetFunction!(inputtedValue);
      },
    );
  }
}
