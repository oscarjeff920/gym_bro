import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/movement/movement_repository.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_id_bloc/get_movement_id_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_id_bloc/get_movement_id_state.dart';

class GetMovementIdBloc
    extends Bloc<GetMovementIdBlocEvents, GetMovementIdInitState> {
  final MovementRepository movementRepository;

  GetMovementIdBloc({required this.movementRepository})
      : super(GetMovementIdInitState());

  @override
  Stream<GetMovementIdInitState> mapEventToState(
      GetMovementIdBlocEvents event) async* {
    if (event is PassMovementDetailsEvent) {
      yield* _mapLoadContextsToState(event);
    } else if (event is PassFinalMovementNameEvent) {
      yield* _mapSimilarMovementsToState(event);
    } else if (event is ResetGetMovementIdEvent) {
      yield GetMovementIdInitState();
    }
  }

  Stream<GetMovementIdInitState> _mapLoadContextsToState(
      PassMovementDetailsEvent event) async* {
    yield QueryingMovementTableState();
    try {
      // first we try to see if the movement exists exactly in the database
      int? existingMovementId = await movementRepository.doesMovementNameExist(
          movementName: event.movementName);

      // if the movement exists we can go straight to providing it's id to the
      // ReceivedMovementIdState to be passed on to add the complete workout
      if (existingMovementId != null) {
        yield ReceivedMovementIdState(
            movementId: existingMovementId, movementName: event.movementName);
      }

      // if the exact movement name doesn't exist in the db we need to check it
      // against similar names that exist to prevent duplicate movements
      else {
        List<MovementMuscleGroupJoin>
            existingMovementNamesWithSamePrimaryMuscleGroup =
            await movementRepository
                .getAllMovementsByMuscleGroup(event.muscleGroup);

        List<MovementMuscleGroupJoin> similarExistingMovementNames =
            returnSimilarExistingMovementNames(
                existingMovementNamesWithSamePrimaryMuscleGroup,
                event.movementName);
        // Here we ask the user if any of the similar named movements
        // are the same as the new movement
        yield CheckSimilarMovementNamesState(
            newMovementName: event.movementName,
            similarDbMovementNames: similarExistingMovementNames);
      }
    } catch (e) {
      print("Whoops.. we've got reached a QueryingErrorMovementTableState\n$e");
      yield QueryingErrorMovementTableState(error: e);
    }
  }

  Stream<GetMovementIdInitState> _mapSimilarMovementsToState(
      PassFinalMovementNameEvent event) async* {
    int finalMovementId;

    if (event.movementId == null) {
      finalMovementId = await movementRepository.insertNewMovement(
          event.movementName, event.primaryMuscleGroup);
    } else {
      finalMovementId = event.movementId!;
    }

    yield ReceivedMovementIdState(
        movementId: finalMovementId, movementName: event.movementName);
  }

  List<MovementMuscleGroupJoin> returnSimilarExistingMovementNames(
      List<MovementMuscleGroupJoin> existingMovements, String newMovementName) {
    List<MovementMuscleGroupJoin> similarExistingMovementNames = [];

    List<String> splitNewMovementName = newMovementName.split(" ");

    // using method removePlurals to convert words like 'curls' to 'curl'
    // for easy comparison
    List<String> newMovementSplitWithoutPlurals =
        removePlurals(splitNewMovementName);

    for (var existingMovement in existingMovements) {
      List<String> splitUpExistingMovement =
          existingMovement.movementName.split(" ");

      // using method removePlurals to convert words like 'curls' to 'curl'
      // for easy comparison
      List<String> existingMovementSplitWithoutPlurals =
          removePlurals(splitUpExistingMovement);

      // if the plural-less movements are the same, add to list
      if (newMovementSplitWithoutPlurals ==
          existingMovementSplitWithoutPlurals) {
        similarExistingMovementNames.add(existingMovement);
        continue;
      }

      // If one of these movements contains the string 'machine',
      // but the other doesn't, then they are different movements
      if (newMovementSplitWithoutPlurals.contains('machine') &&
              !existingMovementSplitWithoutPlurals.contains('machine') ||
          !newMovementSplitWithoutPlurals.contains('machine') &&
              existingMovementSplitWithoutPlurals.contains('machine')) {
        continue;
      }

      // TODO: Add more filtering methods...
    }

    return similarExistingMovementNames;
  }

  List<String> removePlurals(List<String> stringList) {
    return stringList.map((str) {
      if (str.endsWith("es")) {
        return str.substring(0, str.length - 2);
      } else if (str.endsWith("s")) {
        return str.substring(0, str.length - 1);
      }
      return str;
    }).toList();
  }
}
