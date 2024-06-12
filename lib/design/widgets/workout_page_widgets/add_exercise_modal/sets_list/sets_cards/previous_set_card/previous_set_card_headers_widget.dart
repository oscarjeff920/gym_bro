import 'package:flutter/material.dart';

class PreviousSetCardHeaders extends StatelessWidget {
  const PreviousSetCardHeaders(
      {super.key, required this.date, required this.workingSetsCount});

  final String date;
  final int workingSetsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          // color: Colors.black12,
          child: const Text(
            "Last Workout:",
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          // color: Colors.black12,
          child: Text(
            date,
            textScaleFactor: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 25, bottom: 5),
          // color: Colors.black12,
          child: Text(
            "Working Sets: $workingSetsCount",
            textScaleFactor: 0.75,
          ),
        ),
      ],
    );
  }
}
