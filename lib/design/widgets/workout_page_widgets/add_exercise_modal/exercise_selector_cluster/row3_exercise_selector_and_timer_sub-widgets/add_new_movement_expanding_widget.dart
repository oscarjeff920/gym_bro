import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_state.dart';

import 'add_new_movement_expanding_widget_sub-widgets/add_new_movement_name_button_widgets.dart';
import 'add_new_movement_expanding_widget_sub-widgets/add_new_movement_name_sub-widgets.dart';
import 'add_new_movement_expanding_widget_sub-widgets/muscle_group_expanding_widget_sub-widgets.dart';

class AddNewMovementExpandedWidget extends StatelessWidget {
  const AddNewMovementExpandedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewMovementCubit, AddNewMovementState>(
      builder: (context, state) {
        return AnimatedContainer(
          // color: const Color.fromRGBO(5, 5, 5, 0.5),
          color: const Color.fromRGBO(255, 255, 255, 0.8),
          duration: const Duration(milliseconds: 500),
          // Duration of the animation
          curve: Curves.easeInOut,
          // Curve for the animation
          height: state.isNewMovementSelected ? 320 : 0,
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
                  const AddNewMovementNameHeaderWidget(),
                  AddNewMovementNameTextField(
                    newMovementName: state.movementName,
                  ),
                  const SpacerWidget(height: 12),
                  const MuscleGroupHeaderWidget(isPrimary: true),
                  const MuscleGroupIndicatorRowWidget(
                    isPrimary: true,
                  ),
                  const SpacerWidget(height: 12),
                  const MuscleGroupHeaderWidget(
                    isPrimary: false,
                  ),
                  const MuscleGroupIndicatorRowWidget(
                    isPrimary: false,
                  ),
                  const SpacerWidget(height: 12),
                  ButtonRowWidget(
                    newMovementName: state.movementName,
                    workedMuscleGroups: state.workedMuscleGroups
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SpacerWidget extends StatelessWidget {
  const SpacerWidget({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
