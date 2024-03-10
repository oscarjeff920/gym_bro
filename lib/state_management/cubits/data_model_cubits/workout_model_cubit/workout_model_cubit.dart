import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_table_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_model_cubit/workout_model_state.dart';

// class WorkoutModelCubit extends Cubit<WorkoutModelInitState> {
//   WorkoutModelCubit() : super(WorkoutModelInitState());
//
//   loadWorkoutToState(WorkoutTable workout, List<ExerciseTable> exercises) {
//     emit(LoadedWorkoutModelState(
//         id: workout.id,
//         day: workout.day,
//         month: workout.month,
//         year: workout.year,
//         workoutDuration: workout.duration,
//         exercises: exercises.map((exercise) => ExerciseTable.toExerciseModel(exercise)).toList()));
//   }
// }