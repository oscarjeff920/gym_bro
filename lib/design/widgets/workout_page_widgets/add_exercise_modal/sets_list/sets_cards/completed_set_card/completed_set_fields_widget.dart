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
    dynamic usedValue = value;
    if (value is Duration) {
      String hhmmss = value.toString().split('.').first;
      usedValue =
          "${hhmmss.split(":").elementAt(1)}:${hhmmss.split(":").elementAt(2)}";
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$fieldName:",
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
          !isCheckBox
              ? TextField(
                  readOnly: true,
                  controller: TextEditingController()
                    ..text = usedValue == null ? "" : usedValue.toString(),
                  textAlign: TextAlign.center,
                )
              : Checkbox(
                  value: isWarmup,
                  onChanged: null,
                  checkColor: Colors.black,
                  fillColor: MaterialStatePropertyAll<Color>(
                      Colors.black.withOpacity(0)),
                )
        ],
      ),
    );
  }
}
