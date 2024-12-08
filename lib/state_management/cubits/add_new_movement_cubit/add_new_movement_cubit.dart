import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';

import 'add_new_movement_state.dart';

class AddNewMovementCubit extends Cubit<AddNewMovementState> {
  AddNewMovementCubit() : super(const AddNewMovementState());

  openAddNewMovementExpansionPanel() {
    emit(const AddNewMovementState(isNewMovementSelected: true));
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(const AddNewMovementState(
          isNewMovementSelected: true, showAnimatedChildren: true));
    });
  }

  void updateWorkedMuscleGroups(
      bool isPrimary, MuscleGroupType muscleGroup, bool toggleOn) {
    Map<MuscleGroupType, RoleType> updatedWorkedMuscleGroups =
        _muscleGroupButtonToggled(isPrimary, muscleGroup, toggleOn,
            state.workedMuscleGroups!.workedMuscleGroupsMap);

    AddNewMovementState generatedState = state.copyWith(
        copyWorkedMuscleGroups: MovementWorkedMuscleGroupsType(
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
        isPrimary, muscleGroup, toggleOn, currentWorkedMuscleGroups);
  }

  Map<MuscleGroupType, RoleType> _muscleGroupButtonToggled(
      bool isPrimary,
      MuscleGroupType muscleGroup,
      bool toggleOn,
      Map<MuscleGroupType, RoleType> currentWorkedMuscleGroups) {
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

  closeAddNewMovementExpansionPanel() {
    emit(const AddNewMovementState());
  }

  typeMovementName(String name) {
    emit(AddNewMovementState(
        isNewMovementSelected: true,
        showAnimatedChildren: true,
        movementName: name));
  }
}
