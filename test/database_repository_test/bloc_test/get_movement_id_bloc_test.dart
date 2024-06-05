import 'package:flutter_test/flutter_test.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/movement/movement_repository.dart';
import 'package:gym_bro/database/database_connector.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_id_bloc/get_movement_id_bloc.dart';

void main() {
  test('removePlurals', () {
    final getMovementIdBlocInstance = GetMovementIdBloc(
        movementRepository: MovementRepository(DatabaseHelper()));

    List<String> splitMovementName = ['sheep', 'ducks', 'presses'];

    List<String> removedPlurals =
        getMovementIdBlocInstance.removePlurals(splitMovementName);

    List<String> expectedResult = ['sheep', 'duck', 'press'];

    expect(removedPlurals, expectedResult);
  });

  group('returnSimilarExistingMovementNames tests', () {
    final getMovementIdBlocInstance = GetMovementIdBloc(
        movementRepository: MovementRepository(DatabaseHelper()));

    List<MovementMuscleGroupJoin> existingMovements = [
      MovementMuscleGroupJoin(
          movementName: 'bench press',
          muscleRole: RoleType.primary,
          muscleGroup: MuscleGroupType.chest),
      MovementMuscleGroupJoin(
          movementName: 'incline chest press',
          muscleRole: RoleType.primary,
          muscleGroup: MuscleGroupType.chest),
      MovementMuscleGroupJoin(
          movementName: 'machine chest press',
          muscleRole: RoleType.primary,
          muscleGroup: MuscleGroupType.chest),
      MovementMuscleGroupJoin(
          movementName: 'flat fly press',
          muscleRole: RoleType.primary,
          muscleGroup: MuscleGroupType.chest),
    ];

    // test('returnSimilarExistingMovementNames', () {
    //   String newMovementName = 'flat bench press';
    //
    //   List<MovementMuscleGroupJoin> similarMovements =
    //       getMovementIdBlocInstance.returnSimilarExistingMovementNames(
    //           existingMovements, newMovementName
    //       );
    //
    //   List<MovementMuscleGroupJoin> expectedReturnList = [];
    // });
  });
}
