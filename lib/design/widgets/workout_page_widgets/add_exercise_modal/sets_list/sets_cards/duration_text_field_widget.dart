import 'package:flutter/material.dart';

class DurationTextFieldWidget extends StatelessWidget {
  final String? displayDuration;
  final TextStyle textStyle;

  const DurationTextFieldWidget({super.key, this.displayDuration, this.textStyle = const TextStyle(color: Colors.white)});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      style: textStyle,
      controller: TextEditingController()..text = displayDuration ?? "- - -",
      textAlign: TextAlign.center,
    );
  }
}


