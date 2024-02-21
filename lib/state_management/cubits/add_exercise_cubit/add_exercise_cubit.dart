
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/FE_consts/flutter_data_models.dart';
import 'package:gym_bro/FE_consts/enums.dart';

import 'add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit()
      : super(const AddExerciseState(
            selectedMuscleGroup: null,
            selectedExercise: null,
            setsDone: []));

  selectMuscleGroup(MuscleGroupType muscleGroup) {
    emit(AddExerciseState(
        selectedMuscleGroup: muscleGroup,
        selectedExercise: null,
        setsDone: const []));
  }

  selectExercise(String exerciseName) {
    AddExerciseState generatedState = state.copyWith();

    emit(AddExerciseState(
        selectedMuscleGroup: generatedState.selectedMuscleGroup,
        selectedExercise: exerciseName,
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
        selectedExercise: generatedState.selectedExercise,
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
      selectedExercise: generatedState.selectedExercise,
      currentSet: const CurrentSet(),
      setsDone: setsDone
    ));
  }
}
