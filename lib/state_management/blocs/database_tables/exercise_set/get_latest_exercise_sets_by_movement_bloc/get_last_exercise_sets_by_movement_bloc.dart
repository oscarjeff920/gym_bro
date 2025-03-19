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
          previous10ExerciseSessionsSetsData: const [],
          movementPRData: const {});
    } else {
      // Get Previous Exercise Sets
      try {
        // Here we retrieve the last 10 exercises' sets with movement_id == movementId
        List<Map<String, dynamic>> previousSetsGroupsData =
            await exerciseSetRepository
                .getLatestExerciseSetsByMovementIdWrapper(event.movementId!);

        if (previousSetsGroupsData.isEmpty) {
          yield SuccessfulGetLastExerciseSetsByMovementQueryState(
              previous10ExerciseSessionsSetsData: const [],
              movementPRData: const {});
          return;
        }

        List<Map<String, dynamic>> previousExerciseSetsGroups = [];
        for (Map exerciseData in previousSetsGroupsData) {
          Map<String, dynamic> transformedExerciseSetsData = {
            'year': exerciseData['year'],
            'month': exerciseData['month'],
            'day': exerciseData['day'],
            'dateString': state.dateToString(exerciseData['year'],
                exerciseData['month'], exerciseData['day'])
          };

          List<GeneralExerciseSetModel> exerciseSets = exerciseData['sets']
              .map<GeneralExerciseSetModel>((exerciseSet) =>
                  GeneralExerciseSetModel.fromDbMap(map: exerciseSet))
              .toList();

          transformedExerciseSetsData['sets'] = exerciseSets;

          previousExerciseSetsGroups.add(transformedExerciseSetsData);
        }

        // Get Movement PR
        Map movementPRSetObj =
            await exerciseSetRepository.getMovementPRSet(event.movementId!);
        Map<String, dynamic> movementPR = movementPRSetObj['data'];

        GeneralExerciseSetModel movementPRSet =
            GeneralExerciseSetModel.fromDbMap(map: movementPR);

        Map<String, dynamic> returnMovementPRSetObj = {
          'data': movementPRSet,
          'year': movementPRSetObj['year'],
          'month': movementPRSetObj['month'],
          'day': movementPRSetObj['day'],
          'dateString': state.dateToString(movementPRSetObj['year'],
              movementPRSetObj['month'], movementPRSetObj['day'])
        };

        yield SuccessfulGetLastExerciseSetsByMovementQueryState(
            previous10ExerciseSessionsSetsData: previousExerciseSetsGroups,
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
