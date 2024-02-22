import 'package:flutter/material.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';

class WorkoutsList extends StatelessWidget {
  final List<WorkoutModel_HomePage> allWorkouts;

  const WorkoutsList({super.key, required this.allWorkouts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allWorkouts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
              "${allWorkouts[index].year}/${allWorkouts[index].month}/${allWorkouts[index].day}"
          ),
        );
      },
    );
  }
}
