import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/workout_page/add_exercise_modal_widget.dart';
import 'package:gym_bro/enums.dart';
import '../../../state_management/blocs/building_workout_bloc/building_workout_bloc.dart';
import '../../../state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import '../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import '../../widgets/the_app_bar_widget.dart';
import '../../widgets/workout_page/exercises_list_widget.dart';

class NewWorkoutPage extends StatelessWidget {
  const NewWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExerciseCubit, AddExerciseState>(
      builder: (context, state) {
        Color modalColour = const Color.fromRGBO(200, 200, 200, 1);

        double modalWidth = double.infinity;
        double modalHeight = double.infinity;
        Alignment modalAlignment = const Alignment(0, 0);
        if (state.selectedMuscleGroup != null) {
          modalColour = muscleGroupColours[state.selectedMuscleGroup]!;
        }
        return  Scaffold(
          appBar: const TheAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(children: [
              BlocBuilder<BuildingWorkoutBloc, BuildingWorkoutState>(
                builder: (context, state) {
                  return const ExercisesList();
                },
              ),
              AddExerciseModal(
                modalColour: modalColour,
                modalAlignment: modalAlignment,
                modalWidth: modalWidth,
                modalHeight: modalHeight,
              ),
            ]),
          ),
          floatingActionButton: state.openModal ? null : FloatingActionButton(
            child: const Icon(Icons.directions_run),
            onPressed: () {
              BlocProvider.of<AddExerciseCubit>(context).openModal();
            },
          ),
        );
      },
    );
  }
}