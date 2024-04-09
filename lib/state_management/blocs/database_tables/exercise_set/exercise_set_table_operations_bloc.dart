import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_repository.dart';

import 'exercise_set_table_operations_event.dart';
import 'exercise_set_table_operations_state.dart';

class ExerciseSetTableOperationsBloc extends Bloc<
    ExerciseSetTableOperationsEvent, ExerciseSetTableOperationsState> {
  final ExerciseSetRepository exerciseSetRepository;

  ExerciseSetTableOperationsBloc({required this.exerciseSetRepository})
      : super(ExerciseSetTableNotQueriedState());

  @override
  Stream<ExerciseSetTableOperationsState> mapEventToState(ExerciseSetTableOperationsEvent event) async* {
    if (event is QueryAllExerciseSetsByExerciseEvent) {
      yield* _mapLoadContextsToState(event);
    } else if (event is ResetExerciseSetQueryEvent) {
      yield ExerciseSetTableNotQueriedState();
    }
  }

  Stream<ExerciseSetTableOperationsState> _mapLoadContextsToState(
      QueryAllExerciseSetsByExerciseEvent event) async* {
    yield ExerciseSetTableQueryState();
    try {
      List<LoadedExerciseModel> exercisesWithSets = [];

      for (var exercise in event.selectedWorkout.exercises) {
        var query = await exerciseSetRepository.getAllExerciseSetsByExerciseId(exercise.id);
        LoadedExerciseModel newExercise = LoadedExerciseModel(
            id: exercise.id,
            exerciseOrder: exercise.exerciseOrder,
            movementName: exercise.movementName,
            movementId: exercise.movementId,
            exerciseDuration: exercise.exerciseDuration,
            numWorkingSets: exercise.numWorkingSets,
            primaryMuscleGroup: exercise.primaryMuscleGroup,
            exerciseSets: query
                .map((exerciseSet) => LoadedExerciseSetModel(
                id: exerciseSet.id!,
                exerciseSetOrder: exerciseSet.setOrder,
                isWarmUp: exerciseSet.isWarmUp,
                weight: exerciseSet.weight,
                reps: exerciseSet.reps,
                extraReps: exerciseSet.extraReps,
                setDuration: exerciseSet.duration,
                notes: exerciseSet.notes
            )).toList()
        );

        exercisesWithSets.add(newExercise);
      }

      yield ExerciseSetTableSuccessfulQueryAllByExerciseIdState(
          completeWorkout: LoadedWorkoutModel(
              id: event.selectedWorkout.id,
              day: event.selectedWorkout.day,
              month: event.selectedWorkout.month,
              year: event.selectedWorkout.year,
              workoutStartTime: event.selectedWorkout.workoutStartTime,
              workoutDuration: event.selectedWorkout.workoutDuration,
              exercises: exercisesWithSets)
      );
    } catch (e) {
      print("We've reached an ExerciseSetTableQueryErrorState\n$e");
    }
  }
}
