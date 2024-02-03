import 'package:flutter/material.dart';

class CurrentSetFields extends StatelessWidget {
  final String fieldName;
  final bool isCheckBox;
  final Function(dynamic) updateSetFunction;


  const CurrentSetFields({
    super.key,
    required this.fieldName,
    required this.updateSetFunction,
    this.isCheckBox = false,
  });

  @override
  Widget build(BuildContext context) {
    TextInputType textInput =
        fieldName == "Notes" ? TextInputType.text : TextInputType.number;

    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("$fieldName:"),
          !isCheckBox
              ? TextField(
            textInputAction: TextInputAction.next,
                  keyboardType: textInput,
                  textAlign: TextAlign.center,
            onSubmitted: (inputtedValue) {
              print(inputtedValue);
              // updateSetFunction(updateSetFunction);
            },
                )
              : IsWarmupCheckbox(updateSetFunction: updateSetFunction)
        ],
      ),
    );
  }
}

class IsWarmupCheckbox extends StatefulWidget {
  final Function(dynamic) updateSetFunction;

  const IsWarmupCheckbox({
    super.key, required this.updateSetFunction,
  });

  @override
  State<IsWarmupCheckbox> createState() => _IsWarmupCheckboxState();
}

class _IsWarmupCheckboxState extends State<IsWarmupCheckbox> {
  bool isBoxChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isBoxChecked,
        onChanged: (bool? value) {
          setState(() {
            print("setstate: value: $value, isBoxChecked: $isBoxChecked");
            isBoxChecked = value!;
            widget.updateSetFunction(value);
          });
        }
    );
  }
}
