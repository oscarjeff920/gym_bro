import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_object.dart';

import 'exercise_set_model_state.dart';

class ExerciseSetModelCubit extends Cubit<InitExerciseSetModelState> {
  ExerciseSetModelCubit() : super(InitExerciseSetModelState());

  loadExerciseSetToState(ExerciseSetTable exerciseSet) {
    emit(LoadedExerciseSetModelState(
        id: exerciseSet.id,
        exerciseSetOrder: exerciseSet.setOrder,
        isWarmUp: exerciseSet.isWarmUp,
        weight: exerciseSet.weight,
        reps: exerciseSet.reps,
        extraReps: exerciseSet.extraReps,
        repDuration: exerciseSet.duration,
        notes: exerciseSet.notes));
  }

  createNewWorkoutSetToState(NewExerciseSetModel newExerciseSet) {
    emit(NewExerciseSetModelState(
        exerciseSetOrder: newExerciseSet.exerciseSetOrder,
        isWarmUp: newExerciseSet.isWarmUp,
        weight: newExerciseSet.weight,
        reps: newExerciseSet.reps,
        extraReps: newExerciseSet.extraReps,
        repDuration: newExerciseSet.repDuration,
        notes: newExerciseSet.notes));
  }
}
