import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/workout_page/add_exercise_modal_widget.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import '../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

class NewWorkoutPage extends StatelessWidget {
  const NewWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExerciseCubit, AddExerciseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Gym Brooo",
              style: TextStyle(color: Colors.white),
            ),
            elevation: 20,
            backgroundColor: const Color.fromRGBO(230, 120, 50, 1),
            iconTheme: const IconThemeData(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(children: [
              ListView(
                children: [
                  Row(
                    children: [],
                  )
                ],
              ),
              const AddExerciseModal()
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.directions_run),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
