import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';

class MovementMuscleGroupJoin {
  final int? movementId;
  final String movementName;
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  factory MovementMuscleGroupJoin.fromMapWithWorkedMuscleGroups(
      Map<String, dynamic> map,
      MovementWorkedMuscleGroupsType workedMuscleGroups) {
    return MovementMuscleGroupJoin(
        movementId: map['movement_id'],
        movementName: map['movement_name'],
        workedMuscleGroups: workedMuscleGroups);
  }

  MovementMuscleGroupJoin(
      {required this.movementId,
      required this.movementName,
      required this.workedMuscleGroups});
}
