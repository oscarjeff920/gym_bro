import 'package:gym_bro/database/tables/muscle_group/muscle_group_object.dart';
import 'package:gym_bro/database/tables/muscle_group/muscle_group_constants.dart';

import '../../database_connector.dart';

class MuscleGroupRepository {
  final DatabaseHelper databaseHelper;

  MuscleGroupRepository(this.databaseHelper);

  Future<List<MuscleGroup>> getAllMuscleGroups() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allMuscleGroups =
        await db.query(tableName);

    return allMuscleGroups
        .map((muscleGroup) => MuscleGroup.fromMap(muscleGroup))
        .toList();
  }
}
