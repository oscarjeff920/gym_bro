import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_repository.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_event.dart';

class GetLastExerciseSetsByMovementBloc extends Bloc<
    GetLastExerciseSetsByMovementEvent, GetLastExerciseSetsByMovementState> {
  final ExerciseSetRepository exerciseSetRepository;

  GetLastExerciseSetsByMovementBloc({required this.exerciseSetRepository})
      : super(GetLastExerciseSetNotQueriedState());

  @override
  Stream<GetLastExerciseSetsByMovementState> mapEventToState(
      GetLastExerciseSetsByMovementEvent event) async* {
    switch (event) {
      case QueryLastExerciseSetsByMovementEvent():
        yield* _mapLoadMovementIdToState(event);
      case ResetMovementByMuscleGroupEvent():
        yield GetLastExerciseSetNotQueriedState();
    }
  }

  Stream<GetLastExerciseSetsByMovementState> _mapLoadMovementIdToState(
      QueryLastExerciseSetsByMovementEvent event) async* {
    yield GetLastExerciseSetQueryingState();
    try {
      List<Map> results = await exerciseSetRepository
          .getLatestExerciseSetsByMovement(event.movementId);
      List<Sets> lastExerciseSets =
          results.map((exerciseSet) => Sets.fromMap(exerciseSet)).toList();
      yield SuccessfulGetLastExerciseSetsByMovementQueryState(
          lastExerciseSets: lastExerciseSets);
    } catch (e) {
      yield GetLastExerciseSetsQueryErrorState(error: e);
    }
  }
}
