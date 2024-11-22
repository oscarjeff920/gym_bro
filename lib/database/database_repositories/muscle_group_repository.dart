import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

import '../../data_models/database_data_models/tables/muscle_group/muscle_group_object.dart';

class MuscleGroupRepository {
  final DatabaseHelper databaseHelper;

  MuscleGroupRepository(this.databaseHelper);

  Future<List<MuscleGroupTable>> getAllMuscleGroups() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allMuscleGroups =
        await db.query(muscleGroupTableName);

    return allMuscleGroups
        .map((muscleGroup) => MuscleGroupTable.fromMap(muscleGroup))
        .toList();
  }
}
