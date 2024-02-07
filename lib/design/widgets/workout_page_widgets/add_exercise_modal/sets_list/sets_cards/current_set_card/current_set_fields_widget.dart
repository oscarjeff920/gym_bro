import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';

import '../../../../../../../state_management/cubits/set_timer_cubit/set_timer_state.dart';

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
          Text(
            "$fieldName:",
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
          !isCheckBox
              ? TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: textInput,
                  textAlign: TextAlign.center,
                  onSubmitted: (inputtedValue) {
                    print(inputtedValue);
                    updateSetFunction(int.parse(inputtedValue));
                  },
                )
              : IsWarmupCheckbox(updateSetFunction: updateSetFunction),
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
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
          BlocBuilder<SetTimerCubit, SetTimerState>(
            builder: (context, state) {
              return TextField(
                readOnly: true,
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

// class TimerSetField extends CurrentSetFields{
//   const TimerSetField({
//     super.key,
//     super.fieldName = "Set Duration",
//     required super.updateSetFunction
//   });
//
// }

class IsWarmupCheckbox extends StatefulWidget {
  final Function(dynamic) updateSetFunction;

  const IsWarmupCheckbox({
    super.key,
    required this.updateSetFunction,
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
        });
  }
}
