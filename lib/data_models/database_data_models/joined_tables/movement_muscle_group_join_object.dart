import 'package:gym_bro/constants/enums.dart';

// TODO: add all worked muscle groups.
class MovementMuscleGroupJoin {
  final int? movementId;
  final String movementName;
  final RoleType muscleRole;
  final int? muscleGroupId;
  final MuscleGroupType muscleGroupName;

  factory MovementMuscleGroupJoin.fromMap(Map<String, dynamic> map) {
    return MovementMuscleGroupJoin(
      movementId: map['movement_id'],
      movementName: map['movement_name'],
      muscleRole: RoleType.values.byName(map['role']),
      muscleGroupId: map['muscle_group_id'],
      muscleGroupName: MuscleGroupType.values.byName(map['muscle_group_name']),
    );
  }

  MovementMuscleGroupJoin(
      {required this.movementId,
      required this.movementName,
      required this.muscleRole,
      required this.muscleGroupId,
      required this.muscleGroupName});
}
