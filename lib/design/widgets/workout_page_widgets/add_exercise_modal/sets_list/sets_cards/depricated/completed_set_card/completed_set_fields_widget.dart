import 'package:flutter/material.dart';

class CompletedSetFields extends StatelessWidget {
  final String fieldName;
  final dynamic value;
  final bool isCheckBox;
  final bool isWarmup;
  final bool previous;

  const CompletedSetFields({
    super.key,
    required this.fieldName,
    required this.value,
    this.isCheckBox = false,
    this.isWarmup = false,
    this.previous = false
  });

  @override
  Widget build(BuildContext context) {
    dynamic usedValue = value;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$fieldName:",
            style: TextStyle(fontSize: 10, color: previous ? Colors.white: null),
            textAlign: TextAlign.center,
          ),
          !isCheckBox
              ? TextField(
                  readOnly: true,
                  controller: TextEditingController()
                    ..text = usedValue == null ? "" : usedValue.toString(),
                  textAlign: TextAlign.center,
              style: previous ? const TextStyle(color: Colors.white) : null,

                )
              : Checkbox(
                  value: isWarmup,
                  onChanged: null,
                  checkColor: previous? Colors.white : Colors.black,
                  fillColor: WidgetStatePropertyAll<Color>(
                      previous ? Colors.black: Colors.black.withOpacity(0)),
                )
        ],
      ),
    );
  }
}
