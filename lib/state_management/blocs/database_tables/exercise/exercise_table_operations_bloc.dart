import 'package:flutter_bloc/flutter_bloc.dart';
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
    if (event is QueryAllExerciseByWorkoutIdEvent) {
      yield* _mapLoadContextsToState(event);
    }
  }

  Stream<ExerciseTableOperationsState> _mapLoadContextsToState(
      QueryAllExerciseByWorkoutIdEvent event) async* {
    yield ExerciseTableQueryState();
    try {
      // movementRepository.inspectSchema();
      var query = await exerciseRepository.getAllExercisesByWorkoutId(event.workoutId);
      yield ExerciseTableSuccessfulQueryAllState(allExercisesQuery: query);
    }
    catch (e) {
      print("Whoops.. we've got reached a ExerciseTableQueryErrorState\n$e");
      yield ExerciseTableQueryErrorState();
    }
  }
}
