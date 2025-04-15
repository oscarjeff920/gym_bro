import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/constants/utils/custom_datetime_utils.dart';
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
      yield SuccessfulGetLastExerciseSetsByMovementQueryState(returnData: {
        for (ComparisonDisplayType displayType in ComparisonDisplayType.values)
          displayType: []
      });
    } else {
      // Get Previous Exercise Sets
      try {
        // Here we retrieve the last 10 exercises' sets with movement_id == movementId
        List<Map<String, dynamic>> previousSetsGroupsData =
            await exerciseSetRepository
                .getLatestExerciseSetsByMovementIdWrapper(event.movementId!);

        // Get Movement PR
        List<Map<String, dynamic>> movementPRSetsObj =
            await exerciseSetRepository
                .getDistinctPRSetsByMovementIdWrapper(event.movementId!);

        // TODO: should have some sort of copy with here...
        yield SuccessfulGetLastExerciseSetsByMovementQueryState(returnData: {
          ComparisonDisplayType.latest: previousSetsGroupsData,
          ComparisonDisplayType.PR: movementPRSetsObj
        });
      } catch (e, stackTrace) {
        print(
            "error in getting movement PR, GetLastExerciseSetsByMovementBloc: $e");
        print("StackTrace: $stackTrace");
        yield GetLastExerciseSetsQueryErrorState(error: e);
      }
    }
  }
}
