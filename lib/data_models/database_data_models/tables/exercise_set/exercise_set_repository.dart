import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';

import 'exercise_set_object.dart';

class ExerciseSetRepository {
  final DatabaseHelper databaseHelper;

  ExerciseSetRepository(this.databaseHelper);

  Future<List<ExerciseSetTable>> getAllExerciseSetsByExerciseId(int exerciseId) async {
    final db = await databaseHelper.database;

    String dbQuery = """
    SELECT
      $exerciseSetTableName.id,
      $exerciseSetTableName.exercise_id,
      $exerciseSetTableName.set_order,
      $exerciseSetTableName.is_warm_up,
      $exerciseSetTableName.weight,
      $exerciseSetTableName.reps,
      $exerciseSetTableName.extra_reps,
      $exerciseSetTableName.duration,
      $exerciseSetTableName.notes
    FROM $exerciseSetTableName
    WHERE $exerciseSetTableName.exercise_id = $exerciseId
    ORDER BY $exerciseSetTableName.set_order ASC;
    """;

    final List<Map<String, dynamic>> allExerciseSets = await db.rawQuery(dbQuery);

    return allExerciseSets
        .map((exerciseSet) => ExerciseSetTable.fromMap(exerciseSet))
        .toList();
  }
}