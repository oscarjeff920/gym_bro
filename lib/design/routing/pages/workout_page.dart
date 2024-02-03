import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_state.dart';
import '../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import '../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import '../../widgets/the_app_bar_widget.dart';
import '../../widgets/workout_page_widgets/add_exercise_modal_widget.dart';
import '../../widgets/workout_page_widgets/completed_exercises_scaffold_widget.dart';
import '../../widgets/workout_page_widgets/exercise_count_bar_widget.dart';
import '../../widgets/workout_page_widgets/workout_date_timer_widget.dart';

class NewWorkoutPage extends StatelessWidget {
  const NewWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TheAppBar(),
      body: Column(
        children: [
          WorkoutDateTimer(),
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            height: 900 - 154,
            child: Stack(children: [
              // Positioned.fill(child: CompletedExercisesScaffold()),
              Positioned.fill(child: CompletedExercisesScaffold()),
              BlocBuilder<OpenExerciseModalCubit, OpenExerciseModalState>(
                  builder: (context, state) {
                switch (state) {
                  case ExerciseModalOpenedState():
                    return const AddExerciseModal();
                  default:
                    return Container();
                }
              }),
            ]),
          ),
          ExerciseCountBar()
        ],
      ),
    );
  }
}
