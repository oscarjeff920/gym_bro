import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement_muscle_group_join_object.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';
import 'package:gym_bro/database/database_connector.dart';
import 'package:sqflite/sqflite.dart';

class MovementRepository {
  final DatabaseHelper databaseHelper;

  MovementRepository(this.databaseHelper);

  Future<void> inspectSchema() async {
    Database db = await databaseHelper.database;

    print("\n\n========= INSPECTING SCHEMA ==========");
    List<Map<String, dynamic>> tables = await db.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', 'workout'],
    );
    for (Map<String, dynamic> table in tables) {
      String tableName = table['name'];
      print('Table: $tableName');

      List<Map<String, dynamic>> columns = await db.query(tableName);
      for (Map<String, dynamic> column in columns) {
        print('Column: ${column['name']}');
      }
    }
  }

  Future<List<MovementMuscleGroupJoin>> getAllMovementsByMuscleGroup(
      MuscleGroupType selectedMuscleGroup) async {
    final db = await databaseHelper.database;

    String dbQuery = """
        SELECT
          $movementTableName.name AS movement_name,
          $muscleGroupTableName.name AS muscle_group_name,
          *
        FROM $movementTableName

        JOIN $movementMuscleGroupsTableName
          ON $movementTableName.id = $movementMuscleGroupsTableName.movement_id
        JOIN $muscleGroupTableName
          ON $movementMuscleGroupsTableName.muscle_group_id = $muscleGroupTableName.id

        WHERE
          muscle_group_name = '${selectedMuscleGroup.name}'
          AND
          role = 'primary'
          
        ORDER BY
          movement_name ASC
        ;
        """;

    final List<Map<String, dynamic>> movements = await db.rawQuery(dbQuery);
    return movements
        .map((movement) => MovementMuscleGroupJoin.fromMap(movement))
        .toList();
  }
}
