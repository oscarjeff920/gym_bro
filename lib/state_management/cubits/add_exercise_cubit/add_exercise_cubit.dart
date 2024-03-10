
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';

import 'add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit()
      : super(const AddExerciseState(
            selectedMuscleGroup: null,
            selectedMovement: null,
            setsDone: []));

  selectMuscleGroup(MuscleGroupType muscleGroup) {
    emit(AddExerciseState(
        selectedMuscleGroup: muscleGroup,
        selectedMovement: null,
        setsDone: const []));
  }

  selectExercise(String exerciseName) {
    AddExerciseState generatedState = state.copyWith();

    emit(AddExerciseState(
        selectedMuscleGroup: generatedState.selectedMuscleGroup,
        selectedMovement: exerciseName,
        currentSet: const CurrentSet(),
        setsDone: const []));
  }
  updateCurrentSet(CurrentSet set) {
    AddExerciseState generatedState = state.copyWith();

    CurrentSet updatedState = set;
    if (generatedState.currentSet != null) {

      updatedState = CurrentSet(
        isWarmUp: set.isWarmUp ?? generatedState.currentSet!.isWarmUp ?? false,
        weight: set.weight ?? generatedState.currentSet!.weight,
        reps: set.reps ?? generatedState.currentSet!.reps,
        extraReps: set.extraReps ?? generatedState.currentSet!.extraReps,
        setDuration: set.setDuration ?? generatedState.currentSet!.setDuration,
        notes: set.notes ?? generatedState.currentSet!.notes,
      );
    }

    // print("updated set, isWarmUp: ${updatedState.isWarmUp}");
    emit(AddExerciseState(
        selectedMuscleGroup: generatedState.selectedMuscleGroup,
        selectedMovement: generatedState.selectedMovement,
        currentSet: updatedState,
        setsDone: generatedState.setsDone
    ));
  }

  saveCompletedSet() {
    AddExerciseState generatedState = state.copyWith();

    List<Sets> setsDone = [];
    for (var set in generatedState.setsDone) {
      setsDone.add(set);
    }

    Sets completedSet = Sets(
        isWarmUp: generatedState.currentSet!.isWarmUp!,
        weight: generatedState.currentSet!.weight!,
        reps: generatedState.currentSet!.reps!,
        extraReps: generatedState.currentSet!.extraReps,
        setDuration: generatedState.currentSet!.setDuration,
        notes: generatedState.currentSet!.notes
    );
    setsDone.add(completedSet);

    emit(AddExerciseState(
      selectedMuscleGroup: generatedState.selectedMuscleGroup,
      selectedMovement: generatedState.selectedMovement,
      currentSet: const CurrentSet(),
      setsDone: setsDone
    ));
  }
}
