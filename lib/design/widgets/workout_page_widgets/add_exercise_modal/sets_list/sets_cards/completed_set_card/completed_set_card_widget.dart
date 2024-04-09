import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';

import 'completed_set_fields_widget.dart';

class CompletedSetCard extends StatelessWidget {
  final Sets set;

  const CompletedSetCard({
    super.key,
    required this.set,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      color: Colors.white.withOpacity(0.9),
      child: Row(
        children: [
          CompletedSetFields(
              fieldName: "Warm Up",
              isCheckBox: true, isWarmup: set.isWarmUp, value:0 // This is dumb
          ),
          CompletedSetFields(fieldName: "Weight", value: set.weight,),
          CompletedSetFields(fieldName: "Reps", value: set.reps),
          CompletedSetFields(fieldName: "Extra Reps", value: set.extraReps),
          CompletedSetFields(fieldName: "Set Duration", value: set.setDuration),
          CompletedSetFields(fieldName: "Notes", value: set.notes,),


        ],
      ),
    );
  }
}
