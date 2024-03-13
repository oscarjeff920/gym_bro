import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise/exercise_repository.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';

class ExerciseTableOperationsBloc
    extends Bloc<ExerciseTableOperationsEvent, ExerciseTableOperationsState> {
  final ExerciseRepository exerciseRepository;

  ExerciseTableOperationsBloc({required this.exerciseRepository})
      : super(ExerciseTableNotQueriedState());

  @override
  Stream<ExerciseTableOperationsState> mapEventToState(
      ExerciseTableOperationsEvent event) async* {
    if (event is QueryAllExerciseByWorkoutEvent) {
      yield* _mapLoadContextsToState(event);
    } else if (event is ResetExerciseQueryEvent) {
      yield ExerciseTableNotQueriedState();
    }
  }

  Stream<ExerciseTableOperationsState> _mapLoadContextsToState(
      QueryAllExerciseByWorkoutEvent event) async* {
    yield ExerciseTableQueryState();
    try {
      // movementRepository.inspectSchema();
      var query = await exerciseRepository
          .getAllExercisesByWorkoutId(event.selectedWorkout.id!);
      yield ExerciseTableSuccessfulQueryAllByWorkoutIdState(
          selectedWorkout: LoadedWorkoutModel(
              id: event.selectedWorkout.id!,
              day: event.selectedWorkout.day,
              month: event.selectedWorkout.month,
              year: event.selectedWorkout.year,
              workoutStartTime: event.selectedWorkout.workoutStartTime,
              workoutDuration: event.selectedWorkout.duration,
              exercises: query));
    } catch (e) {
      print("Whoops.. we've got reached a ExerciseTableQueryErrorState\n$e");
      yield ExerciseTableQueryErrorState();
    }
  }
}
