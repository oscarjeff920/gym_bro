
import 'package:flutter/material.dart';
import 'package:gym_bro/database/data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal_sub-widgets/sets_list_sub-widgets/completed_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal_sub-widgets/sets_list_sub-widgets/current_set_card_widget.dart';

class SetsList extends StatelessWidget {
  final CurrentSet? currentSet;
  final List<Sets> doneSets;

  const SetsList({
    super.key,
    required this.currentSet,
    required this.doneSets,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 7,
        child: ListView(
          children: [
            if (currentSet != null) const CurrentSetCard(),
            for (var set in doneSets)
              CompletedSetCard(set: set)
          ],
        ));
  }
}
