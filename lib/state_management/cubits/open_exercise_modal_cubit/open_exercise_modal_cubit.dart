import 'package:flutter_bloc/flutter_bloc.dart';

import 'open_exercise_modal_state.dart';

class OpenExerciseModalCubit extends Cubit<OpenExerciseModalState> {
  OpenExerciseModalCubit() : super(ExerciseModalClosedState());

  openExerciseModal () {
    emit(ExerciseModalOpenedState());
  }

  closeExerciseModal () {
    emit(ExerciseModalClosedState());
  }

  toggleExerciseModal () {
    switch (state) {
      case ExerciseModalClosedState():
        emit(ExerciseModalOpenedState());
      case ExerciseModalOpenedState():
        emit(ExerciseModalClosedState());
    }
  }
}