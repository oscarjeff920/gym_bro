import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';

import 'add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit()
      : super(const AddExerciseState(
            selectedMuscleGroup: null,
            selectedMovement: null,
            selectedMovementId: null,
            numWorkingSets: 0,
            setsDone: []));

  clearSavedExercise() {
    emit(const AddExerciseState(
        selectedMuscleGroup: null,
        selectedMovement: null,
        selectedMovementId: null,
        numWorkingSets: 0,
        setsDone: []));
  }

  selectMuscleGroup(MuscleGroupType muscleGroup) {
    emit(AddExerciseState(
        selectedMuscleGroup: muscleGroup,
        selectedMovement: null,
        selectedMovementId: null,
        setsDone: const [],
        numWorkingSets: 0));
  }

  selectExercise(MovementMuscleGroupJoin movementMuscleGroupJoin) {
    AddExerciseState generatedState = state.copyWith();

    emit(AddExerciseState(
        selectedMuscleGroup: generatedState.selectedMuscleGroup,
        selectedMovement: movementMuscleGroupJoin.movementName,
        selectedMovementId: movementMuscleGroupJoin.movementId,
        currentSet: const CurrentSet(),
        setsDone: const [],
        numWorkingSets: 0));
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
        selectedMovementId: generatedState.selectedMovementId,
        currentSet: updatedState,
        setsDone: generatedState.setsDone,
        numWorkingSets: generatedState.numWorkingSets));
  }

  saveCompletedSet() {
    AddExerciseState generatedState = state.copyWith();

    // storing all previous sets in a new array 'setsDone'
    // for the latest set to be added to then passed to the new state
    List<Sets> setsDone = [];
    for (var set in generatedState.setsDone) {
      setsDone.add(set);
    }

    // converting the completed set from CurrentSet to Sets
    Sets completedSet = Sets(
        isWarmUp: generatedState.currentSet!.isWarmUp!,
        weight: generatedState.currentSet!.weight!,
        reps: generatedState.currentSet!.reps!,
        extraReps: generatedState.currentSet!.extraReps,
        setDuration: generatedState.currentSet!.setDuration,
        notes: generatedState.currentSet!.notes);
    setsDone.add(completedSet);

    emit(AddExerciseState(
        selectedMuscleGroup: generatedState.selectedMuscleGroup,
        selectedMovement: generatedState.selectedMovement,
        selectedMovementId: generatedState.selectedMovementId,
        currentSet: const CurrentSet(),
        setsDone: setsDone,
        numWorkingSets: completedSet.isWarmUp
            ? generatedState.numWorkingSets
            : generatedState.numWorkingSets + 1));
  }
}
