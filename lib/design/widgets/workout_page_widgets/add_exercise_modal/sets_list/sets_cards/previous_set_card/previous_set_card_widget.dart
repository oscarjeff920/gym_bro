import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';

class PreviousSetCard extends StatelessWidget {
  final GeneralExerciseSetModel set;
  final int? setNumber;

  const PreviousSetCard(
      {super.key, required this.set, required this.setNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, top: 7),
                    child: Text(
                      "Warm Up:",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Checkbox(
                  value: set.isWarmUp,
                  onChanged: null,
                  checkColor: Colors.white,
                  fillColor:
                      const MaterialStatePropertyAll<Color>(Colors.black),
                ),
              ])),
          PreviousSetColumns(title: "Weight", value: set.weight),
          PreviousSetColumns(title: "Reps", value: set.reps),
          PreviousSetColumns(title: "Extra Reps", value: set.extraReps),
          PreviousSetColumns(title: "Set Duration", value: set.setDuration),
          PreviousSetColumns(title: "Notes", value: set.notes),
          PreviousSetColumns(title: "Set Number", value: setNumber ?? '-')
        ],
      ),
    );
  }
}

class PreviousSetColumns extends StatelessWidget {
  const PreviousSetColumns(
      {super.key, required this.title, required this.value});

  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    String validatedValue = value == null ? "" : value.toString();
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "$title:",
                style: const TextStyle(fontSize: 10, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(validatedValue,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
