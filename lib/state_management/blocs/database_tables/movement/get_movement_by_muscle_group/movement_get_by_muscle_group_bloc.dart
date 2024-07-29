import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/movement/movement_repository.dart';

import 'movement_get_by_muscle_group_event.dart';
import 'movement_get_by_muscle_group_state.dart';

class MovementByMuscleGroupBloc
    extends Bloc<MovementByMuscleGroupEvent, MovementGetByMuscleGroupState> {
  final MovementRepository movementRepository;

  MovementByMuscleGroupBloc({required this.movementRepository})
      : super(MovementGetByMuscleGroupNotQueriedState());

  @override
  Stream<MovementGetByMuscleGroupState> mapEventToState(
      MovementByMuscleGroupEvent event) async* {
    switch (event) {
      case QueryMovementByPrimaryMuscleEvent():
        yield* _mapLoadContextsToState(event);
      case ResetMovementByMuscleGroupEvent():
        yield MovementGetByMuscleGroupNotQueriedState();
    }
  }

  Stream<MovementGetByMuscleGroupState> _mapLoadContextsToState(
      QueryMovementByPrimaryMuscleEvent event) async* {
    yield MovementGetByMuscleGroupQueryState();
    try {
      // movementRepository.inspectSchema();
      var query = await movementRepository.getAllMovementsByPrimaryMuscleGroup(
          event.selectedMuscleGroup);
      yield MovementGetByMuscleGroupSuccessfulQueryState(fetchedMovementsList: query);
    }
    catch (e) {
      print("error in MovementGetByMuscleGroupBloc: $e");
      yield MovementGetByMuscleGroupQueryErrorState(error: e);
    }
  }
}
