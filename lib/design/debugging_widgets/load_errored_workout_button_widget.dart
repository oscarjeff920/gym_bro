import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/save_error_state_cubit/save_error_state_cubit.dart';
import 'package:gym_bro/state_management/cubits/save_error_state_cubit/save_error_state_state.dart';

class LoadErroredWorkoutButton extends StatelessWidget {
  final bool loadFromAssetDebug;

  const LoadErroredWorkoutButton({super.key, required this.loadFromAssetDebug});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveErrorStateCubit, SaveErrorStateState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            if (state.errorStateData.isEmpty) {
              BlocProvider.of<SaveErrorStateCubit>(context)
                  .loadErroredWorkoutToState(isDebug: loadFromAssetDebug);
            } else {
              BlocProvider.of<ActiveWorkoutCubit>(context)
                  .loadSavedJsonWorkoutToState(state.errorStateData);
            }
          },
          backgroundColor: loadFromAssetDebug
              ? Colors.green
              : state.errorStateData.isNotEmpty
                  ? Colors.red
                  : null,
          child: state.errorStateData.isNotEmpty
              ? const Icon(Icons.file_download_sharp)
              : const Icon(Icons.add),
        );
      },
    );
  }
}
