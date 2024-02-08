
import 'package:flutter/material.dart';
import 'package:gym_bro/FE_consts/flutter_data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/completed_set_card/completed_set_card_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/current_set_card/current_set_card_widget.dart';
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
    return ListView(
      children: [
        if (currentSet != null) CurrentSetCard(currentSet: currentSet),
        for (var set in doneSets)
          CompletedSetCard(set: set)
      ],
    );
  }
}
