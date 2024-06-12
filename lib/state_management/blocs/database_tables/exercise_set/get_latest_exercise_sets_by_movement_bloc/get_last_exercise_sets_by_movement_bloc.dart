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
    try {
      if (event.movementId == null) {
        yield SuccessfulGetLastExerciseSetsByMovementQueryState(
            lastExerciseSets: const [], date: "");
      } else {
        Map results = await exerciseSetRepository
            .getLatestExerciseSetsByMovement(event.movementId!);

        print(results);
        print(results['data']);
        List<Map> retrievedSets = results['data'];
        if (retrievedSets.isEmpty) {
          yield SuccessfulGetLastExerciseSetsByMovementQueryState(
              lastExerciseSets: const [], date: "");
          return;
        }

        List<Sets> lastExerciseSets = retrievedSets
            .map((exerciseSet) => Sets.fromMap(exerciseSet))
            .toList();

        String dateString;
        if (results['year'] == null) {
          dateString = "";
        } else {
          dateString = state.dateToString(
              results['year'], results['month'], results['day']);
        }
        yield SuccessfulGetLastExerciseSetsByMovementQueryState(
            lastExerciseSets: lastExerciseSets, date: dateString);
      }
    } catch (e) {
      print("error in GetLastExerciseSetsByMovementBloc: $e");
      yield GetLastExerciseSetsQueryErrorState(error: e);
    }
  }
}
