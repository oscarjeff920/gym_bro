
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
    emit(const AddExerciseState(
        openModal: true,
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

  addReps(Sets sets) {
    AddExerciseState generatedState = state.copyWith();

    var newSetsDone = generatedState.setsDone;
    newSetsDone.add(sets);

    emit(AddExerciseState(
      openModal: true,
      selectedMuscleGroup: generatedState.selectedMuscleGroup,
      selectedExercise: generatedState.selectedExercise,
      setsDone: newSetsDone
    ));
  }
}
