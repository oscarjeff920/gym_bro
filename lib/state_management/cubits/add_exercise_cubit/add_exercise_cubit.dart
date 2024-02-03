
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/database/data_models.dart';
import 'package:gym_bro/enums.dart';

import 'add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit()
      : super(const AddExerciseState(
            openModal: false,
            selectedMuscleGroup: null,
            selectedExercise: null,
            setsDone: []));

  openModal() {
    print("Well.. the modal opened");
    emit(const AddExerciseState(
        openModal: true,
        selectedMuscleGroup: null,
        selectedExercise: null,
        setsDone: []));
  }

  closeModal() {
    emit(const AddExerciseState(
        openModal: false,
        selectedMuscleGroup: null,
        selectedExercise: null,
        setsDone: []));
  }

  selectMuscleGroup(MuscleGroup muscleGroup) {
    emit(AddExerciseState(
        openModal: true,
        selectedMuscleGroup: muscleGroup,
        selectedExercise: null,
        setsDone: const []));
  }

  selectExercise(String exerciseName) {
    AddExerciseState generatedState = state.copyWith();

    emit(AddExerciseState(
        openModal: true,
        selectedMuscleGroup: generatedState.selectedMuscleGroup,
        selectedExercise: exerciseName,
        setsDone: const []));
  }
  updateCurrentSet(CurrentSet set) {
    AddExerciseState generatedState = state.copyWith();

    CurrentSet updatedState = set;
    if (generatedState.currentSet != null) {

      updatedState = CurrentSet(
        weight: generatedState.currentSet!.weight ?? set.weight,
        reps: generatedState.currentSet!.reps ?? set.reps,
        isWarmUp: set.isWarmUp ?? generatedState.currentSet!.isWarmUp,
        notes: generatedState.currentSet!.notes ?? set.notes,
      );
    }

    print("updated set, isWarmUp: ${updatedState.isWarmUp}");
    emit(AddExerciseState(
        openModal: true,
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
        weight: generatedState.currentSet!.weight!,
        reps: generatedState.currentSet!.reps!,
        isWarmUp: generatedState.currentSet!.isWarmUp!,
        notes: generatedState.currentSet!.notes
    );
    setsDone.add(completedSet);

    emit(AddExerciseState(
      openModal: true,
      selectedMuscleGroup: generatedState.selectedMuscleGroup,
      selectedExercise: generatedState.selectedExercise,
      currentSet: null,
      setsDone: setsDone
    ));
  }
}
