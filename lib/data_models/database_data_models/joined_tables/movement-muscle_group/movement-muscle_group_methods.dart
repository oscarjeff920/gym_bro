import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';

class MovementWorkedMuscleGroupsType {
  final Map<MuscleGroupType, RoleType> workedMuscleGroupsMap;

  MovementWorkedMuscleGroupsType({required this.workedMuscleGroupsMap});

  static Future<List<Map<String, dynamic>>>
      queryDbForWorkedMuscleGroupsByMovementId(int movementId, db) async {
    String queryString = """
      SELECT 
        $movementMuscleGroupsTableName.role as role,
        $muscleGroupTableName.name as name
      FROM 
        $movementMuscleGroupsTableName
        
      JOIN $muscleGroupTableName
        ON $movementMuscleGroupsTableName.muscle_group_id = $muscleGroupTableName.id
        
      WHERE
        $movementMuscleGroupsTableName.movement_id = $movementId
    """;

    List<Map<String, dynamic>> result = await db.rawQuery(queryString);

    return result;
  }

  // to convert map retrieved when querying muscle groups by movement id
  factory MovementWorkedMuscleGroupsType.fromDbMap(
      {required List<Map<String, dynamic>> dbMap}) {
    Map<MuscleGroupType, RoleType> musclesWorked = {};
    for (var obj in dbMap) {
      RoleType role = RoleType.values.byName(obj['role']);
      MuscleGroupType muscleGroup = MuscleGroupType.values.byName(obj['name']);

      musclesWorked[muscleGroup] = role;
    }

    MovementWorkedMuscleGroupsType generatedMovementMovementWorkedMuscleGroups =
        MovementWorkedMuscleGroupsType(workedMuscleGroupsMap: musclesWorked);

    return generatedMovementMovementWorkedMuscleGroups;
  }

  // Pairs together the query of the movementMuscleGroups and muscleGroups table by movementId
  // and the generation of an instance of MovementWorkedMuscleGroupsType
  static Future<MovementWorkedMuscleGroupsType>
      getWorkedMuscleGroupsByMovementId(int movementId, db) async {
    List<Map<String, dynamic>> result =
        await queryDbForWorkedMuscleGroupsByMovementId(movementId, db);

    MovementWorkedMuscleGroupsType generatedMovementWorkedMuscleGroupsType =
        MovementWorkedMuscleGroupsType.fromDbMap(dbMap: result);

    return generatedMovementWorkedMuscleGroupsType;
  }

  // convert the object into a map, used mostly for saving state as json
  Map<String, String> toMap() {
    Map<String, String> typeAsMap = {};

    for (var entry in workedMuscleGroupsMap.entries) {
      typeAsMap[entry.key.name] = entry.value.name;
    }

    return typeAsMap;
  }

  // convert the object back from a map, used mostly for restoring state from json
  factory MovementWorkedMuscleGroupsType.fromJsonMap(
      {required Map<String, dynamic> map}) {
    Map<MuscleGroupType, RoleType> workedMuscleGroupsMap = {};

    for (var entry in map.entries) {
      workedMuscleGroupsMap[MuscleGroupType.values.byName(entry.key)] =
          RoleType.values.byName(entry.value);
    }

    return MovementWorkedMuscleGroupsType(
        workedMuscleGroupsMap: workedMuscleGroupsMap);
  }

  // For a movement this method returns all the primary muscle groups involved
  List<MuscleGroup> returnPrimaryMuscleGroups() {
    List<MuscleGroup> primaryMuscleGroups = [];
    for (var muscleGroupPair in workedMuscleGroupsMap.entries) {
      if (muscleGroupPair.value == RoleType.primary) {
        primaryMuscleGroups
            .add(MuscleGroup.allMuscleGroups[muscleGroupPair.key]!);
      }
    }
    return primaryMuscleGroups;
  }

  // For a movement this method returns all the secondary muscle groups involved
  List<MuscleGroup> returnSecondaryMuscleGroups() {
    List<MuscleGroup> secondaryMuscleGroups = [];
    for (var muscleGroupPair in workedMuscleGroupsMap.entries) {
      if (muscleGroupPair.value == RoleType.secondary) {
        secondaryMuscleGroups
            .add(MuscleGroup.allMuscleGroups[muscleGroupPair.key]!);
      }
    }
    return secondaryMuscleGroups;
  }

  int getWorkingSetsPerMuscleGroup(
      MuscleGroupType muscleGroup, int workingSets) {
    if (workedMuscleGroupsMap.containsKey(muscleGroup)) {
      return workingSets;
    }
    return 0;
  }

  // When tallying the number of working sets per muscle group per week
  // we want to convert all the secondary muscle groups sets into
  int calculateWorkingSetsPerMuscleGroup(
      MuscleGroupType muscleGroup, int workingSets) {
    if (workedMuscleGroupsMap.containsKey(muscleGroup)) {
      if (workedMuscleGroupsMap[muscleGroup] == RoleType.primary) {
        return workingSets;
      }
      return (workingSets / 2).floor();
    }
    return 0;
  }

  bool isMuscleGroupWorked(MuscleGroupType muscleGroupType) {
    if (workedMuscleGroupsMap.containsKey(muscleGroupType)) return true;
    return false;
  }

  bool isMuscleGroupWorkedWithRole(
      MuscleGroupType muscleGroupType, RoleType roleType) {
    if (workedMuscleGroupsMap.containsKey(muscleGroupType) &&
        workedMuscleGroupsMap[muscleGroupType] == roleType) return true;
    return false;
  }
}
