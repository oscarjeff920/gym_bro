import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/enums.dart';

import 'add_exercise_state.dart';

class AddExerciseCubit extends Cubit<AddExerciseState> {
  AddExerciseCubit() : super(const AddExerciseState(selectedMuscleGroup: null));

  selectMuscleGroup (MuscleGroup selectedMuscleGroup) {
    emit(AddExerciseState(selectedMuscleGroup: selectedMuscleGroup));
  }
}
