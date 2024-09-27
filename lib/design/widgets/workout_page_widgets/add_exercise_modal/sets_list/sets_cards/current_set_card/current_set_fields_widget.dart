import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';

import '../../../../../../../state_management/cubits/set_timer_cubit/set_timer_state.dart';

class CurrentSetFields extends StatelessWidget {
  final String fieldName;
  final bool isCheckBox;
  final dynamic currentValue;
  final Function(dynamic) updateSetFunction;
  final TextEditingController controller_;
  final bool? isBetter;

  const CurrentSetFields(
      {super.key,
      required this.fieldName,
      this.isCheckBox = false,
      required this.currentValue,
      required this.updateSetFunction,
      required this.controller_,
      this.isBetter});

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    TextInputType textInput =
        fieldName == "Notes" ? TextInputType.text : TextInputType.number;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "$fieldName:",
            style: const TextStyle(fontSize: 10, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          !isCheckBox
              ? TextField(
                  controller: TextEditingController()
                    ..text = currentValue == null ? "" : currentValue.toString(),
                  textInputAction: TextInputAction.next,
                  keyboardType: textInput,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isBetter == null
                          ? Colors.white
                          : isBetter!
                              ? Colors.green
                              : Colors.red),
                  cursorColor: Colors.white,
                  // controller: _controller,
                  onSubmitted: (inputtedValue) {
                    print("--------> cha inputtedValue: $inputtedValue");
                    if (inputtedValue != "") {
                      updateSetFunction(textInput == TextInputType.text
                          ? inputtedValue
                          : fieldName.toLowerCase() == "weight"
                              ? double.parse(inputtedValue)
                              : int.parse(inputtedValue));
                    }
                  },
                )
              : IsWarmupCheckbox(updateSetFunction: updateSetFunction, isBoxChecked: currentValue,),
        ],
      ),
    );
  }
}

class TimerSetField extends StatelessWidget {
  const TimerSetField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Set Duration:",
            style: TextStyle(fontSize: 10, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          BlocBuilder<SetTimerCubit, SetTimerState>(
            builder: (context, state) {
              return TextField(
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                controller: TextEditingController()..text = state.toString(),
                textAlign: TextAlign.center,
              );
            },
          )
        ],
      ),
    );
  }
}

class IsWarmupCheckbox extends StatefulWidget {
  final Function(dynamic) updateSetFunction;
  final bool isBoxChecked;

  const IsWarmupCheckbox({
    super.key,
    required this.updateSetFunction,
    required this.isBoxChecked
  });

  @override
  State<IsWarmupCheckbox> createState() => _IsWarmupCheckboxState();
}

class _IsWarmupCheckboxState extends State<IsWarmupCheckbox> {

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: widget.isBoxChecked,
        checkColor: Colors.white,
        fillColor: WidgetStatePropertyAll<Color>(Colors.black.withOpacity(0)),
        onChanged: (bool? value) {
          setState(() {
            print("setstate: value: $value, isBoxChecked: ${widget.isBoxChecked}");
            widget.updateSetFunction(value);
          });
        });
  }
}
