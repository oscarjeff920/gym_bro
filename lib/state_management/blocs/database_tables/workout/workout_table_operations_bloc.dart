import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_repository.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_state.dart';

class WorkoutTableOperationsBloc
    extends Bloc<WorkoutTableOperationsEvent, WorkoutTableOperationsState> {
  final WorkoutRepository workoutRepository;

  WorkoutTableOperationsBloc({required this.workoutRepository})
      : super(WorkoutTableNotQueriedState());

  @override
  Stream<WorkoutTableOperationsState> mapEventToState(
      WorkoutTableOperationsEvent event) async* {
    if (event is QueryAllWorkoutTableEvent) {
      yield* _mapLoadContextsToState(event);
    }
  }

  Stream<WorkoutTableOperationsState> _mapLoadContextsToState(
      QueryAllWorkoutTableEvent event) async* {
    yield WorkoutTableQueryState();
    try {
      // movementRepository.inspectSchema();
      var query = await workoutRepository.getAllWorkouts();
      yield WorkoutTableSuccessfulQueryAllState(allWorkoutsQuery: query);
    }
    catch (e) {
      print("Whoops.. we've got reached a WorkoutTableQueryErrorState\n$e");
      yield WorkoutTableQueryErrorState();
    }
  }
}
