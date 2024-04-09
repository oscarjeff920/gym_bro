import 'package:flutter_bloc/flutter_bloc.dart';

import 'open_exercise_modal_state.dart';

class OpenExerciseModalCubit extends Cubit<OpenExerciseModalState> {
  OpenExerciseModalCubit() : super(const ExerciseModalClosedState());

  openExerciseModal () {
    emit(const ExerciseModalOpenedState());
  }

  closeExerciseModal () {
    emit(const ExerciseModalClosedState());
  }

  toggleExerciseModal () {
    switch (state) {
      case ExerciseModalClosedState():
        emit(const ExerciseModalOpenedState());
      case ExerciseModalOpenedState():
        emit(const ExerciseModalClosedState());
    }
  }
}