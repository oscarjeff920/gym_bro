import 'package:flutter_test/flutter_test.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';

void main() {
  group('_muscleGroupButtonToggled', () {
    Map<MuscleGroupType, RoleType> initWorkedMuscleGroups = {
      MuscleGroupType.chest: RoleType.primary,
      MuscleGroupType.triceps: RoleType.secondary
    };
    AddNewMovementCubit mockCubit = AddNewMovementCubit();
    test('toggleOn new primary muscle group successfully adds it', () {
      Map<MuscleGroupType, RoleType> actualResult = mockCubit.testMuscleGroupButtonToggled(
          isPrimary: true,
          muscleGroup: MuscleGroupType.shoulders,
          toggleOn: true,
          currentWorkedMuscleGroups: initWorkedMuscleGroups
      );

      Map<MuscleGroupType, RoleType> expectedResult = {
        MuscleGroupType.chest: RoleType.primary,
        MuscleGroupType.triceps: RoleType.secondary,
        MuscleGroupType.shoulders: RoleType.primary
      };

      expect(actualResult, expectedResult);
    });
    test('toggleOn new secondary muscle group successfully adds it', () {
      Map<MuscleGroupType, RoleType> actualResult = mockCubit.testMuscleGroupButtonToggled(
          isPrimary: false,
          muscleGroup: MuscleGroupType.shoulders,
          toggleOn: true,
          currentWorkedMuscleGroups: initWorkedMuscleGroups
      );

      Map<MuscleGroupType, RoleType> expectedResult = {
        MuscleGroupType.chest: RoleType.primary,
        MuscleGroupType.triceps: RoleType.secondary,
        MuscleGroupType.shoulders: RoleType.secondary
      };

      expect(actualResult, expectedResult);
    });
    test('toggleOff existing primary muscle group successfully removes it', () {
      Map<MuscleGroupType, RoleType> actualResult = mockCubit.testMuscleGroupButtonToggled(
          isPrimary: true,
          muscleGroup: MuscleGroupType.chest,
          toggleOn: false,
          currentWorkedMuscleGroups: initWorkedMuscleGroups
      );

      Map<MuscleGroupType, RoleType> expectedResult = {
        MuscleGroupType.triceps: RoleType.secondary,
      };

      expect(actualResult, expectedResult);
    });
  });
}
