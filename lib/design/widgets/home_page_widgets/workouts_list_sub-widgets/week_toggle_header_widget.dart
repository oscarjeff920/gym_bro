import 'package:flutter/material.dart';

class WeekToggleHeader extends StatelessWidget {
  const WeekToggleHeader(
      {super.key,
        required this.headerString,
        required this.index,
        required this.weekStartDate,
        this.isCurrentWeek = false,
        this.isToggledOn = false});

  final bool isToggledOn;
  final bool isCurrentWeek;
  final String headerString;
  final int index;
  final DateTime weekStartDate;

  @override
  Widget build(BuildContext context) {
    String headerString = isCurrentWeek ? "Current Week" : "Week Beginning";
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(8),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        minimumSize: MaterialStateProperty.all(Size(0, 0)),
        backgroundColor: MaterialStateProperty.all(isCurrentWeek ? Colors.amber : Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0), // Square corners
        )),
      ),
      onPressed: isCurrentWeek ? null : () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                // 108 pixels is the minimum size for the larger string
                width: 108 + 40,
                child: Text(
                  "$headerString: ",
                  style: TextStyle(
                      fontWeight:
                      isCurrentWeek ? FontWeight.w800 : FontWeight.w500),
                ),
              ),
              // Container(width: 1, height: 100, color: Colors.black,),
              Text(
                // "Week Beginning: "
                "${weekStartDate.day < 10 ? "0${weekStartDate.day}" : weekStartDate.day}/"
                    "${weekStartDate.month < 10 ? "0${weekStartDate.month}" : weekStartDate.month}/"
                    "${weekStartDate.year}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Icon(isToggledOn ? Icons.arrow_drop_down : Icons.arrow_right),
        ],
      ),
    );
  }
}