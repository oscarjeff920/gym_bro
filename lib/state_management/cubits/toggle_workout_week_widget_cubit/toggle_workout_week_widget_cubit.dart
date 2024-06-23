import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/cubits/toggle_workout_week_widget_cubit/toggle_workout_week_widget_state.dart';

class ToggleWorkoutWeekWidgetCubit extends Cubit<ToggleWorkoutWeekWidgetState> {
  ToggleWorkoutWeekWidgetCubit() : super(ToggleWorkoutWeekWidgetInitState());

  loadWorkoutWeeks(List<MapEntry<DateTime, Map<int, List<LoadedWorkoutModel>>>> workoutWeeks) {
    List<bool> openedWorkoutWeeks = [true];
    for (int n = 1; n < workoutWeeks.length; n++) {
      openedWorkoutWeeks.add(false);
    }

    emit(ToggleWorkoutWeekWidgetLoadedWeeksState(isExpandedArray: openedWorkoutWeeks));
  }

  toggleWorkoutWeek(int workoutWeekIndex) {
    if (state is ToggleWorkoutWeekWidgetLoadedWeeksState) {
      ToggleWorkoutWeekWidgetLoadedWeeksState currentState = state as ToggleWorkoutWeekWidgetLoadedWeeksState;

      List<bool> updatedArray = List.from(currentState.isExpandedArray);
      updatedArray[workoutWeekIndex] = !updatedArray[workoutWeekIndex];

      emit(ToggleWorkoutWeekWidgetLoadedWeeksState(isExpandedArray: updatedArray));

      // ToggleWorkoutWeekWidgetLoadedWeeksState generatedState = currentState.copyWith()
    }
  }
}