import 'package:gym_bro/database/data_models/tables/muscle_group/muscle_group_object.dart';
import 'package:gym_bro/database/data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

class MuscleGroupRepository {
  final DatabaseHelper databaseHelper;

  MuscleGroupRepository(this.databaseHelper);

  Future<List<MuscleGroup>> getAllMuscleGroups() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> allMuscleGroups =
        await db.query(muscleGroupTableName);

    return allMuscleGroups
        .map((muscleGroup) => MuscleGroup.fromMap(muscleGroup))
        .toList();
  }
}
