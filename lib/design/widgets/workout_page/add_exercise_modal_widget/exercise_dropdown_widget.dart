import 'package:flutter/material.dart';

class ExerciseDropdown extends StatelessWidget {
  const ExerciseDropdown({super.key, required this.dropdownContents});

  final List dropdownContents;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: [
        for (var item in dropdownContents)
          DropdownMenuItem(
            value: item.toString(),
            child: Text(item.toString().split(".")[1]),
          )
      ],
      onChanged: (String? value) {},
    );
  }
}
