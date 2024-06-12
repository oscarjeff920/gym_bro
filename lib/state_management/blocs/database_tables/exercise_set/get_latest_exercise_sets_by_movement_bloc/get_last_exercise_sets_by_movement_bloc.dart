import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/tables/exercise_set/exercise_set_repository.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';

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
      case ResetGetLastExerciseSetsByMovementEvent():
        yield GetLastExerciseSetNotQueriedState();
    }
  }

  Stream<GetLastExerciseSetsByMovementState> _mapLoadMovementIdToState(
      QueryLastExerciseSetsByMovementEvent event) async* {
    yield GetLastExerciseSetQueryingState();
    if (event.movementId == null) {
      yield SuccessfulGetLastExerciseSetsByMovementQueryState(
          lastExerciseSetsData: const {}, movementPRData: const {});
    } else {
      // Get Previous Exercise Sets
      try {
        Map previousSetsObj = await exerciseSetRepository
            .getLatestExerciseSetsByMovement(event.movementId!);
        List<Map> retrievedPreviousSets = previousSetsObj['data'];
        if (retrievedPreviousSets.isEmpty) {
          yield SuccessfulGetLastExerciseSetsByMovementQueryState(
              lastExerciseSetsData: previousSetsObj, movementPRData: const {});
          return;
        }

        List<Sets> previousExerciseSets = retrievedPreviousSets
            .map((exerciseSet) => Sets.fromMap(exerciseSet))
            .toList();

        Map returnPreviousExerciseSetsObj = {
          'data': previousExerciseSets,
          'dateString': state.dateToString(previousSetsObj['year'],
              previousSetsObj['month'], previousSetsObj['day'])
        };

        // Get Movement PR
        Map movementPRSetObj =
            await exerciseSetRepository.getMovementPRSet(event.movementId!);
        Map movementPR = movementPRSetObj['data'];

        Sets movementPRSet = Sets.fromMap(movementPR);

        Map returnMovementPRSetObj = {
          'data': movementPRSet,
          'dateString': state.dateToString(movementPRSetObj['year'],
              movementPRSetObj['month'], movementPRSetObj['day'])
        };

        yield SuccessfulGetLastExerciseSetsByMovementQueryState(
            lastExerciseSetsData: returnPreviousExerciseSetsObj,
            movementPRData: returnMovementPRSetObj);
      } catch (e) {
        print(
            "error in getting movement PR, GetLastExerciseSetsByMovementBloc: $e");
        yield GetLastExerciseSetsQueryErrorState(error: e);
      }
    }
  }
}
