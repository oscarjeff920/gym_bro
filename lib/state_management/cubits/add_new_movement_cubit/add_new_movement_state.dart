import 'package:equatable/equatable.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';

class AddNewMovementState extends Equatable {
  final bool isNewMovementSelected;
  final bool showAnimatedChildren;
  final String? movementName;
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  const AddNewMovementState(
      {this.isNewMovementSelected = false,
      this.showAnimatedChildren = false,
      this.movementName,
      required this.workedMuscleGroups});

  AddNewMovementState copyWith(
      {bool? isNewMovementSelectedCopy, bool? showAnimatedChildrenCopy,String? movementNameCopy,
      MovementWorkedMuscleGroupsType? workedMuscleGroupsCopy}) {
    return AddNewMovementState(
      isNewMovementSelected: isNewMovementSelectedCopy ?? isNewMovementSelected,
      showAnimatedChildren: showAnimatedChildrenCopy ?? showAnimatedChildren,
      movementName: movementNameCopy ?? movementName,
      workedMuscleGroups: workedMuscleGroupsCopy ?? workedMuscleGroups,
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
