import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row1_title_sub-widgets/primary_muscle_group_heading_container_widget.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/exercise_selector_cluster/row3_exercise_selector_and_timer_sub-widgets/exercise_selector_container_widget.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_state.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_state.dart';

import 'row2_muscle_group_buttons_sub-widgets/muscle_group_buttons_widget.dart';

class ExerciseSelectorCluster extends StatelessWidget {
  final Color modalColour;
  final String? muscleGroupName;

  const ExerciseSelectorCluster({
    super.key,
    required this.modalColour,
    this.muscleGroupName,
  });

  @override
  Widget build(BuildContext context) {
    double rowHeight = 70;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PrimaryMuscleGroupHeadingContainer(
            currentMuscleGroupName: muscleGroupName, usedHeight: rowHeight),
        MuscleGroupButtons(usedHeight: rowHeight),
        ExerciseSelectorContainer(
            modalColour: modalColour, usedHeight: rowHeight),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
          child: BlocBuilder<AddNewMovementCubit, AddNewMovementState>(
            builder: (context, state) {
              return AnimatedContainer(
                // color: const Color.fromRGBO(5, 5, 5, 0.5),
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                duration: const Duration(milliseconds: 500),
                // Duration of the animation
                curve: Curves.easeInOut,
                // Curve for the animation
                height: state.isNewMovementSelected ? 175 : 0,
                // Height of the container
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: state.showAnimatedChildren ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "Exercise Name:",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(10, 10, 10, .6),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 35,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.bottom,
                              controller: TextEditingController()
                                ..text = state.movementName ?? "",
                              decoration: const InputDecoration(
                                  prefix: SizedBox(
                                width: 10,
                              )),
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                              onSubmitted: (String inputText) {
                                BlocProvider.of<AddNewMovementCubit>(context)
                                    .typeMovementName(inputText.trim());
                              },
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            "Primary Muscle Group:",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(10, 10, 10, 0.6),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 30,
                            child:
                                BlocBuilder<AddExerciseCubit, AddExerciseState>(
                              builder: (context, state) {
                                return TextField(
                                  decoration: const InputDecoration(
                                      prefix: SizedBox(
                                    width: 10,
                                  )),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  controller: TextEditingController()
                                    ..text = state.muscleGroupToString() ?? "",
                                  readOnly: true,
                                );
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      BlocProvider.of<AddNewMovementCubit>(
                                              context)
                                          .closeAddNewMovementExpansionPanel(),
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    size: 40,
                                  )),
                              IconButton(
                                disabledColor: Colors.black.withOpacity(0),
                                onPressed: state.movementName != null
                                    ? () {
                                        BlocProvider.of<AddExerciseCubit>(
                                                context)
                                            .addNewMovement(
                                                state.movementName!);
                                        BlocProvider.of<AddNewMovementCubit>(
                                                context)
                                            .closeAddNewMovementExpansionPanel();
                                      }
                                    : null,
                                icon: const Icon(Icons.check_circle_outline,
                                    size: 40),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
