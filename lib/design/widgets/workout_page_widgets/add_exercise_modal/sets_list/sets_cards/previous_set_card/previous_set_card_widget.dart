import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/completed_set_card/completed_set_fields_widget.dart';

class PreviousSetCard extends StatelessWidget {
  final Sets set;
  final int setNumber;

  const PreviousSetCard(
      {super.key, required this.set, required this.setNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      color: Colors.black,
      child: Row(
        children: [
          CompletedSetFields(
              fieldName: "Warm Up",
              isCheckBox: true,
              isWarmup: set.isWarmUp,
              value: 0,
              // This is dumb
              previous: true),
          CompletedSetFields(
            fieldName: "Weight",
            value: set.weight,
            previous: true,
          ),
          CompletedSetFields(
              fieldName: "Reps", value: set.reps, previous: true),
          CompletedSetFields(
              fieldName: "Extra Reps", value: set.extraReps, previous: true),
          CompletedSetFields(
              fieldName: "Set Duration",
              value: set.setDuration,
              previous: true),
          CompletedSetFields(
              fieldName: "Notes", value: set.notes, previous: true),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Set Number:",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                TextField(
                    readOnly: true,
                    controller: TextEditingController()
                      ..text = setNumber.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
