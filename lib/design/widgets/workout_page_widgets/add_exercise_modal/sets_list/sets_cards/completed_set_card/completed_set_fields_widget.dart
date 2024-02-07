import 'package:flutter/material.dart';

class CompletedSetFields extends StatelessWidget {
  final String fieldName;
  final dynamic value;
  final bool isCheckBox;
  final bool isWarmup;

  const CompletedSetFields({
    super.key,
    required this.fieldName,
    required this.value,
    this.isCheckBox = false,
    this.isWarmup = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("$fieldName:"),
          !isCheckBox
              ? Text(
            value,
            textAlign: TextAlign.center,
          )
              : Checkbox(value: isWarmup, onChanged: (aValue) {})
        ],
      ),
    );
  }
}
