import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/workout_page/add_exercise_modal_widget/exercise_dropdown_widget.dart';
import 'package:gym_bro/design/widgets/workout_page/add_exercise_modal_widget/muscle_group_button_widget.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import '../../../enums.dart';
import '../../../state_management/cubits/add_exercise_cubit/add_exercise_state.dart';

List<String> mockDropdownList = [
  'Chest Press',
  'Squats',
  'Deadlift',
  'Pull Ups',
  'Shoulder Press',
];

class AddExerciseModal extends StatelessWidget {
  const AddExerciseModal({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BlocConsumer<AddExerciseCubit, AddExerciseState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          Color modalColour = ThemeData().dividerColor;
          if (state.selectedMuscleGroup != null) {
            modalColour =
                state.colourModalByPrimaryMuscle(state.selectedMuscleGroup!);
          }
          return AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            color: modalColour,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: const Color.fromRGBO(5, 5, 5, 0.3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Expanded(
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Center(
                                              child: Text(
                                                  "Primary Muscle Group:"))),
                                    ),
                                    if (state.muscleGroupToString() != null)
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Center(
                                            child: Text(
                                              state.muscleGroupToString()!,
                                              textScaleFactor: 1.5,
                                            ),
                                          ),
                                        ),
                                      )
                                    else
                                      Expanded(child: Container())
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (var group in MuscleGroup.values.toList())
                                  MuscleGroupButton(
                                      muscleGroup: group,
                                      iconColour: state
                                          .colourModalByPrimaryMuscle(group))
                              ],
                            ))
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.red,
                    )),
                Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.green,
                      child: ListView(
                        children: [],
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
