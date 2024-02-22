import 'package:gym_bro/FE_consts/enums.dart';
import 'package:gym_bro/constants/enums.dart';

class MovementMuscleGroups {
  final int movementId;
  final int muscleGroupId;
  final RoleType role;

  MovementMuscleGroups(
      {required this.movementId,
      required this.muscleGroupId,
      required this.role});

  factory MovementMuscleGroups.fromMap(Map<String, dynamic> map) {
    return MovementMuscleGroups(
        movementId: map['movement_id'],
        muscleGroupId: map['muscle_group_id'],
        role: map['role'] == 'primary' ? RoleType.primary : RoleType.secondary);
  }

  Map<String, dynamic> toMap() {
    return {
      'movement_id': movementId,
      'muscle_group_id': muscleGroupId,
      'role': role.toString()
    };
  }
}
