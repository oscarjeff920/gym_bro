import 'package:flutter/material.dart';

class WorkingSetCount extends StatelessWidget {
  const WorkingSetCount(
      {super.key, required this.setNumber, required this.isCurrent});

  final int? setNumber;
  final bool isCurrent;

  String get workingSetString => isCurrent ? "Current " : "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          setNumber == null
              ? "Warm up Set"
              : "${workingSetString}Working Set: ",
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.6),
            fontSize: 11,
          ),
        ),
        Text(
          setNumber == null ? "" : "$setNumber",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
