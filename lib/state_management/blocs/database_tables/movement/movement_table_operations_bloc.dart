import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/movement/movement_repository.dart';

import 'movement_table_operations_event.dart';
import 'movement_table_operations_state.dart';

class MovementTableOperationsBloc
    extends Bloc<MovementTableOperationsEvent, MovementTableOperationsState> {
  final MovementRepository movementRepository;

  MovementTableOperationsBloc({required this.movementRepository})
      : super(MovementTableNotQueriedState());

  @override
  Stream<MovementTableOperationsState> mapEventToState(
      MovementTableOperationsEvent event) async* {
    if (event is QueryMovementByPrimaryMuscleEvent) {
      yield* _mapLoadContextsToState(event);
    }
  }

  Stream<MovementTableOperationsState> _mapLoadContextsToState(
      QueryMovementByPrimaryMuscleEvent event) async* {
    yield MovementTableQueryState();
    try {
      // movementRepository.inspectSchema();
      var query = await movementRepository.getAllMovementsByMuscleGroup(
          event.selectedMuscleGroup);
      yield MovementTableSuccessfulQueryState(queryResponse: query);
    }
    catch (e) {
      yield MovementTableQueryErrorState();
    }
  }
}
