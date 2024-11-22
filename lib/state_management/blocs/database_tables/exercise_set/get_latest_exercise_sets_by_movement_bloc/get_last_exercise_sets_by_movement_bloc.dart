import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/database/database_repositories/exercise_set_repository.dart';
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
        List<Map<String, dynamic>> retrievedPreviousSets = previousSetsObj['data'];
        if (retrievedPreviousSets.isEmpty) {
          yield SuccessfulGetLastExerciseSetsByMovementQueryState(
              lastExerciseSetsData: previousSetsObj, movementPRData: const {});
          return;
        }

        List<GeneralExerciseSetModel> previousExerciseSets = retrievedPreviousSets
            .map((exerciseSet) => GeneralExerciseSetModel.fromDbMap(map: exerciseSet))
            .toList();

        Map<String, dynamic> returnPreviousExerciseSetsObj = {
          'data': previousExerciseSets,
          'dateString': state.dateToString(previousSetsObj['year'],
              previousSetsObj['month'], previousSetsObj['day'])
        };

        // Get Movement PR
        Map movementPRSetObj =
            await exerciseSetRepository.getMovementPRSet(event.movementId!);
        Map<String, dynamic> movementPR = movementPRSetObj['data'];

        GeneralExerciseSetModel movementPRSet = GeneralExerciseSetModel.fromDbMap(map: movementPR);

        Map<String, dynamic> returnMovementPRSetObj = {
          'data': movementPRSet,
          'dateString': state.dateToString(movementPRSetObj['year'],
              movementPRSetObj['month'], movementPRSetObj['day'])
        };

        yield SuccessfulGetLastExerciseSetsByMovementQueryState(
            lastExerciseSetsData: returnPreviousExerciseSetsObj,
            movementPRData: returnMovementPRSetObj);
      } catch (e, stackTrace) {
        print(
            "error in getting movement PR, GetLastExerciseSetsByMovementBloc: $e");
        print("StackTrace: $stackTrace");
        yield GetLastExerciseSetsQueryErrorState(error: e);
      }
    }
  }
}
