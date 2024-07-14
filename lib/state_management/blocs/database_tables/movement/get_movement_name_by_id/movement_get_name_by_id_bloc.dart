import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/movement/movement_repository.dart';

import 'movement_get_name_by_id_event.dart';
import 'movement_get_name_by_id_state.dart';

class MovementGetNameByIdBloc
    extends Bloc<MovementGetNameByIdEvent, MovementGetNameByIdState> {
  final MovementRepository movementRepository;

  MovementGetNameByIdBloc({required this.movementRepository})
      : super(MovementGetNameByIdNotQueriedState());

  @override
  Stream<MovementGetNameByIdState> mapEventToState(
      MovementGetNameByIdEvent event) async* {
    switch (event) {
      case QueryMovementNameByIdEvent():
        yield* _mapLoadContextsToState(event);
      case ResetMovementGetNameByIdEvent():
        yield MovementGetNameByIdNotQueriedState();
    }
  }

  Stream<MovementGetNameByIdState> _mapLoadContextsToState(
      QueryMovementNameByIdEvent event) async* {
    yield MovementGetNameByIdQueryState();
    try {
      // movementRepository.inspectSchema();
      var query = await movementRepository.fetchAndIndexMovementNameById(
          event.namelessExercises);
      yield MovementGetNameByIdSuccessfulQueryState(exerciseMovementNameIndex: query);
    }
    catch (e) {
      print("error in MovementGetNameByIdBloc: $e");
      yield MovementGetNameByIdQueryErrorState(error: e);
    }
  }
}
