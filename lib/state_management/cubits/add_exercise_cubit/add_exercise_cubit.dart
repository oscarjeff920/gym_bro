import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';

import 'add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit()
      : super(AddExerciseState(
            selectedMovement: null,
            selectedMovementId: null,
            numWorkingSets: 0,
            setsDone: const [],
            workedMuscleGroups:
                MovementWorkedMuscleGroupsType(workedMuscleGroupsMap: {})));

  addCompletedExercise(GeneralWorkoutPageExerciseModel completedExercise) {
    AddExerciseState newState = AddExerciseState(
        selectedMovement: completedExercise.movementName,
        selectedMovementId: completedExercise.movementId,
        setsDone: completedExercise.exerciseSets,
        numWorkingSets: completedExercise.numWorkingSets,
        workedMuscleGroups: completedExercise.workedMuscleGroups);

    emit(newState);
  }

  clearSavedExercise() {
    emit(AddExerciseState(
        selectedMovement: null,
        selectedMovementId: null,
        numWorkingSets: 0,
        setsDone: const [],
        workedMuscleGroups:
            MovementWorkedMuscleGroupsType(workedMuscleGroupsMap: {})));
  }

  selectMuscleGroup(MuscleGroup muscleGroup) {
    emit(AddExerciseState(
        selectedMovement: null,
        selectedMovementId: null,
        setsDone: const [],
        numWorkingSets: 0,
        workedMuscleGroups: MovementWorkedMuscleGroupsType(
            workedMuscleGroupsMap: {muscleGroup.type: RoleType.primary})));
  }

  selectExercise(MovementMuscleGroupJoin movementMuscleGroupJoin) {
    emit(AddExerciseState(
        selectedMovement: movementMuscleGroupJoin.movementName,
        selectedMovementId: movementMuscleGroupJoin.movementId,
        workedMuscleGroups: movementMuscleGroupJoin.workedMuscleGroups,
        currentSet: const CurrentSet(isWarmUp: true),
        setsDone: const [],
        numWorkingSets: 0));
  }

  addNewMovement(String newMovementName,
      MovementWorkedMuscleGroupsType workedMuscleGroups) {
    AddExerciseState generatedState = state.copyWith(
        selectedMovementNameCopy: newMovementName,
        currentSetCopy: const CurrentSet(isWarmUp: true),
        setsDoneCopy: const [],
        numWorkingSetsCopy: 0,
        movementWorkedMuscleGroupsCopy: workedMuscleGroups);

    emit(generatedState);
  }

  // Updating State CurrentSet
  // ============================
  // as theres no way to differentiate between null values explicitly set
  // and null values due to omitted field assignment:
  //    exSet = CurrentSet(reps: null);
  //    exSet.reps == null && exSet.weight == null
  // there's no good way of updating a field to null with a generalised method
  // the update set method has been split for each field
  // that could be meaningfully set to null
  void _emitUpdatedCurrentSetState(CurrentSet updatedSet) {
    AddExerciseState currentState = state.copyWith();

    emit(AddExerciseState(
      selectedMovement: currentState.selectedMovement,
      selectedMovementId: currentState.selectedMovementId,
      currentSet: updatedSet,
      setsDone: currentState.setsDone,
      numWorkingSets: currentState.numWorkingSets,
      workedMuscleGroups: currentState.workedMuscleGroups,
    ));
  }

  // Generalised method for fields that can't be meaningfully re-set to null on update
  // isWarmUp, setDuration
  updateCurrentSet(CurrentSet set) {
    AddExerciseState currentState = state.copyWith();

    CurrentSet updatedSet;
    if (currentState.currentSet != null) {
      updatedSet = CurrentSet(
        isWarmUp: set.isWarmUp ?? currentState.currentSet!.isWarmUp,
        weight: set.weight ?? currentState.currentSet!.weight,
        reps: set.reps ?? currentState.currentSet!.reps,
        extraReps: set.extraReps ?? currentState.currentSet!.extraReps,
        setDuration: set.setDuration ?? currentState.currentSet!.setDuration,
        notes: set.notes ?? currentState.currentSet!.notes,
      );
    } else {
      updatedSet = const CurrentSet();
    }

    _emitUpdatedCurrentSetState(updatedSet);
  }

  updateWeightCurrentSet(double? weight) {
    AddExerciseState currentState = state.copyWith();

    CurrentSet updatedSet;
    if (currentState.currentSet != null) {
      updatedSet = CurrentSet(
        isWarmUp: currentState.currentSet!.isWarmUp,
        weight: weight,
        reps: currentState.currentSet!.reps,
        extraReps: currentState.currentSet!.extraReps,
        setDuration: currentState.currentSet!.setDuration,
        notes: currentState.currentSet!.notes,
      );
    } else {
      updatedSet = const CurrentSet();
    }

    _emitUpdatedCurrentSetState(updatedSet);
  }

  updateRepsCurrentSet(int? reps) {
    AddExerciseState currentState = state.copyWith();

    CurrentSet updatedSet;
    if (currentState.currentSet != null) {
      updatedSet = CurrentSet(
        isWarmUp: currentState.currentSet!.isWarmUp,
        weight: currentState.currentSet!.weight,
        reps: reps,
        extraReps: currentState.currentSet!.extraReps,
        setDuration: currentState.currentSet!.setDuration,
        notes: currentState.currentSet!.notes,
      );
    } else {
      updatedSet = const CurrentSet();
    }

    _emitUpdatedCurrentSetState(updatedSet);
  }

  updateExtraRepsCurrentSet(int? extraReps) {
    AddExerciseState currentState = state.copyWith();

    CurrentSet updatedSet;
    if (currentState.currentSet != null) {
      updatedSet = CurrentSet(
        isWarmUp: currentState.currentSet!.isWarmUp,
        weight: currentState.currentSet!.weight,
        reps: currentState.currentSet!.reps,
        extraReps: extraReps,
        setDuration: currentState.currentSet!.setDuration,
        notes: currentState.currentSet!.notes,
      );
    } else {
      updatedSet = const CurrentSet();
    }

    _emitUpdatedCurrentSetState(updatedSet);
  }

  updateNotesCurrentSet(String? notes) {
    AddExerciseState currentState = state.copyWith();

    CurrentSet updatedSet;
    if (currentState.currentSet != null) {
      updatedSet = CurrentSet(
        isWarmUp: currentState.currentSet!.isWarmUp,
        weight: currentState.currentSet!.weight,
        reps: currentState.currentSet!.reps,
        extraReps: currentState.currentSet!.extraReps,
        setDuration: currentState.currentSet!.setDuration,
        notes: notes,
      );
    } else {
      updatedSet = const CurrentSet();
    }

    _emitUpdatedCurrentSetState(updatedSet);
  }

  // ==============================

  void saveCompletedSet() {
    AddExerciseState generatedState = state.copyWith();

    // storing all previous sets in a new array 'setsDone'
    // for the latest set to be added to then passed to the new state
    List<GeneralExerciseSetModel> setsDone = [];
    for (var set in generatedState.setsDone) {
      setsDone.add(set);
    }

    // converting the completed set from CurrentSet to Sets
    GeneralExerciseSetModel completedSet = GeneralExerciseSetModel(
        isWarmUp: generatedState.currentSet!.isWarmUp!,
        weight: generatedState.currentSet!.weight!,
        reps: generatedState.currentSet!.reps!,
        extraReps: generatedState.currentSet!.extraReps,
        setDuration: generatedState.currentSet!.setDurationToString(),
        exerciseSetOrder: setsDone.length + 1,
        notes: generatedState.currentSet!.notes);
    setsDone.add(completedSet);

    // preparing for proceeding set
    emit(AddExerciseState(
        selectedMovement: generatedState.selectedMovement,
        selectedMovementId: generatedState.selectedMovementId,
        currentSet: CurrentSet(
            isWarmUp: completedSet.isWarmUp, weight: completedSet.weight),
        setsDone: setsDone,
        numWorkingSets: completedSet.isWarmUp
            ? generatedState.numWorkingSets
            : generatedState.numWorkingSets + 1,
        workedMuscleGroups: generatedState.workedMuscleGroups));
  }
}
