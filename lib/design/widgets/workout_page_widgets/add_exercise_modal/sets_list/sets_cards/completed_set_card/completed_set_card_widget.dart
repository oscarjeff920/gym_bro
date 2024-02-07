import 'package:flutter/material.dart';
import 'package:gym_bro/database/data_models.dart';

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
      color: Colors.white38.withOpacity(0.4),
      child: Row(
        children: [
          CompletedSetFields(fieldName: "Weight", value: set.weight,),
          CompletedSetFields(fieldName: "Reps", value: set.reps),
          CompletedSetFields(
            fieldName: "Warm Up",
            isCheckBox: true, isWarmup: set.isWarmUp, value:0 // This is dumb
          ),
          CompletedSetFields(fieldName: "Notes", value: set.notes,),


        ],
      ),
    );
  }
}
