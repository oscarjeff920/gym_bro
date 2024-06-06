import 'package:gym_bro/constants/enums.dart';

class MovementMuscleGroupJoin {
  final int? movementId;
  final String movementName;
  final RoleType muscleRole;
  final int? muscleGroupId;
  final MuscleGroupType muscleGroup;

  factory MovementMuscleGroupJoin.fromMap(Map<String, dynamic> map) {
    return MovementMuscleGroupJoin(
      movementId: map['movement_id'],
      movementName: map['movement_name'],
      muscleRole: RoleType.values.byName(map['role']),
      muscleGroupId: map['muscle_group_id'],
      muscleGroup: MuscleGroupType.values.byName(map['muscle_group_name']),
    );
  }

  MovementMuscleGroupJoin(
      {this.movementId,
      required this.movementName,
      required this.muscleRole,
      this.muscleGroupId,
      required this.muscleGroup});
}
