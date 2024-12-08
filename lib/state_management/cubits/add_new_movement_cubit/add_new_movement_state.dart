import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';

class AddNewMovementState extends Equatable {
  final bool isNewMovementSelected;
  final bool showAnimatedChildren;
  final String? movementName;
  final MovementWorkedMuscleGroupsType? workedMuscleGroups;

  const AddNewMovementState(
      {this.isNewMovementSelected = false,
      this.showAnimatedChildren = false,
      this.movementName,
      this.workedMuscleGroups});

  AddNewMovementState copyWith(
      {String? copyMovementName,
      MovementWorkedMuscleGroupsType? copyWorkedMuscleGroups}) {
    return AddNewMovementState(
      isNewMovementSelected: isNewMovementSelected,
      showAnimatedChildren: showAnimatedChildren,
      movementName: copyMovementName ?? movementName,
      workedMuscleGroups: copyWorkedMuscleGroups ?? workedMuscleGroups,
    );
  }

  @override
  List<Object?> get props => [
        isNewMovementSelected,
        showAnimatedChildren,
        movementName,
        workedMuscleGroups
      ];
}
