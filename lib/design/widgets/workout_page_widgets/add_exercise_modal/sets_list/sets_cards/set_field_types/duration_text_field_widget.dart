import 'package:flutter/material.dart';
import 'package:gym_bro/constants/enums.dart';

class DurationTextFieldWidget extends StatelessWidget {
  final String? displayDuration;
  final SetType setType;

  const DurationTextFieldWidget(
      {super.key, required this.displayDuration, required this.setType});

  Color get activeColour =>
      setType == SetType.completed ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: const InputDecoration(border: InputBorder.none),
      style: TextStyle(color: activeColour),
      controller: TextEditingController()..text = displayDuration ?? "- - -",
      textAlign: TextAlign.center,
    );
  }
}
