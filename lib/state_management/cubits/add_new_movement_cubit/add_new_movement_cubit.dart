import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';

import 'add_new_movement_state.dart';

class AddNewMovementCubit extends Cubit<AddNewMovementState> {
  AddNewMovementCubit()
      : super(AddNewMovementState(
            workedMuscleGroups:
                MovementWorkedMuscleGroupsType(workedMuscleGroupsMap: {})));

  openAddNewMovementExpansionPanel() {
    AddNewMovementState generatedState1 =
        state.copyWith(isNewMovementSelectedCopy: true);
    emit(generatedState1);
    Future.delayed(const Duration(milliseconds: 500), () {
      AddNewMovementState generatedState2 = state.copyWith(
          isNewMovementSelectedCopy: true, showAnimatedChildrenCopy: true);
      emit(generatedState2);
    });
  }

  void addSelectedMuscleGroupToWorkedMuscleGroups(
      MuscleGroup selectedMuscleGroup) {
    AddNewMovementState generatedState = state.copyWith(
        workedMuscleGroupsCopy: MovementWorkedMuscleGroupsType(
            workedMuscleGroupsMap: {
          selectedMuscleGroup.type: RoleType.primary
        }));
    emit(generatedState);
  }

  void updateWorkedMuscleGroups(
      {required bool isPrimary,
      required MuscleGroupType muscleGroup,
      required bool toggleOn}) {
    Map<MuscleGroupType, RoleType> updatedWorkedMuscleGroups =
        _muscleGroupButtonToggled(
            isPrimary: isPrimary,
            muscleGroup: muscleGroup,
            toggleOn: toggleOn,
            currentWorkedMuscleGroups:
                state.workedMuscleGroups!.workedMuscleGroupsMap);

    AddNewMovementState generatedState = state.copyWith(
        workedMuscleGroupsCopy: MovementWorkedMuscleGroupsType(
            workedMuscleGroupsMap: updatedWorkedMuscleGroups));
    emit(generatedState);
  }

  // Public Wrapper for testing of _muscleGroupButtonToggled
  Map<MuscleGroupType, RoleType> testMuscleGroupButtonToggled(
      {required bool isPrimary,
      required MuscleGroupType muscleGroup,
      required bool toggleOn,
      required Map<MuscleGroupType, RoleType> currentWorkedMuscleGroups}) {
    return _muscleGroupButtonToggled(
        isPrimary: isPrimary,
        muscleGroup: muscleGroup,
        toggleOn: toggleOn,
        currentWorkedMuscleGroups: currentWorkedMuscleGroups);
  }

  Map<MuscleGroupType, RoleType> _muscleGroupButtonToggled(
      {required bool isPrimary,
      required MuscleGroupType muscleGroup,
      required bool toggleOn,
      required Map<MuscleGroupType, RoleType> currentWorkedMuscleGroups}) {
    // TODO: need to add some validation so that you cant have one muscle group being both primary and secondary
    RoleType newMuscleGroupRole =
        isPrimary ? RoleType.primary : RoleType.secondary;

    if (toggleOn) {
      if (currentWorkedMuscleGroups.containsKey(muscleGroup) &&
          currentWorkedMuscleGroups[muscleGroup] == newMuscleGroupRole) {
        print("toggleOn but $muscleGroup-$newMuscleGroupRole already exists..");
        // once auto toggling of initial primary has been set up we can throw this error
        // if the muscle group is being toggled on, it shouldn't exist in the map
        // throw Error('');
      } else {
        currentWorkedMuscleGroups[muscleGroup] = newMuscleGroupRole;
      }
    } else {
      if (currentWorkedMuscleGroups.containsKey(muscleGroup) &&
          currentWorkedMuscleGroups[muscleGroup] == newMuscleGroupRole) {
        RoleType? removedRole = currentWorkedMuscleGroups.remove(muscleGroup);
      } else {
        print("toggleOff but $muscleGroup-$newMuscleGroupRole doesn't exist..");
        // if the workedMuscleGroupsMap is being toggled off, it should already exist in
        // the workedMuscleGroups, if it doesn't something has gone wrong
        // throw Error();
      }
    }

    return currentWorkedMuscleGroups;
  }

  addWorkedMuscleGroup(MovementWorkedMuscleGroupsType workedMuscleGroups) {
    AddNewMovementState generatedState =
        state.copyWith(workedMuscleGroupsCopy: workedMuscleGroups);
    emit(generatedState);
  }

  closeAddNewMovementExpansionPanel() {
    emit(AddNewMovementState(
        workedMuscleGroups:
            MovementWorkedMuscleGroupsType(workedMuscleGroupsMap: {})));
  }

  typeMovementName(String name) {
    // TODO: do these need to be explicitly stated?
    AddNewMovementState generatedState = state.copyWith(
        isNewMovementSelectedCopy: true,
        showAnimatedChildrenCopy: true,
        movementNameCopy: name);
    emit(generatedState);
  }
}
