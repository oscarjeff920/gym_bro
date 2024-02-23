import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/cubits/workout_page_workout_cubit/workout_page_workout_cubit.dart';

class WorkoutsList extends StatelessWidget {
  final List<WorkoutModel_HomePage> allWorkouts;

  const WorkoutsList({super.key, required this.allWorkouts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: allWorkouts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Center(
            child: Text(
                "${allWorkouts[index].year}/${allWorkouts[index].month}/${allWorkouts[index].day}"),
          ),
          tileColor: Colors.white,
          onTap: () {
            BlocProvider.of<WorkoutPageWorkoutCubit>(context)
                .loadWorkout(allWorkouts[index]);
            Navigator.of(context).pushNamed("/new-workout-page");
          },
        );
      },
    );
  }
}
