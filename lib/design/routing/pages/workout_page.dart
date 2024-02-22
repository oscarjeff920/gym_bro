import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_state.dart';
import '../../widgets/the_app_bar_widget.dart';
import '../../widgets/workout_page_widgets/add_exercise_modal/add_exercise_modal_widget.dart';
import '../../widgets/workout_page_widgets/completed_exercises_scaffold/completed_exercises_scaffold_widget.dart';
import '../../widgets/workout_page_widgets/exercise_count_bar/exercise_count_bar_widget.dart';
import '../../widgets/workout_page_widgets/workout_date_timer_widget.dart';

class WorkoutOverviewPage extends StatelessWidget {
  const WorkoutOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // CHANGE!!!
    double tileSpacingValue = 12;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TheAppBar(),
      body: Column(
        children: [
          Material(elevation:2, child: const WorkoutDateTimer()),
          Expanded(
            child: Container(
              // COMBINE-SPACING!
              child: Stack(children: [
                Positioned.fill(
                    child: CompletedExercisesScaffold(
                        tileSpacingValue: tileSpacingValue)),
                BlocBuilder<OpenExerciseModalCubit, OpenExerciseModalState>(
                  builder: (context, state) {
                    double fadedValue;
                    switch (state) {
                      case ExerciseModalOpenedState():
                        fadedValue = 0.8;
                      default:
                        fadedValue = 0;
                    }
                    return IgnorePointer(
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          color: Colors.black.withOpacity(fadedValue)
                      ),
                    );
                  },
                ),
                BlocBuilder<OpenExerciseModalCubit, OpenExerciseModalState>(
                    builder: (context, state) {
                      return IgnorePointer(
                        ignoring: !state.isOpen,
                        child: AnimatedOpacity(
                            opacity: state.isOpen ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: const AddExerciseModal(),
                        ),
                      );
                    }),
              ]),
            ),
          ),
          const ExerciseCountBar()
        ],
      ),
    );
  }
}
