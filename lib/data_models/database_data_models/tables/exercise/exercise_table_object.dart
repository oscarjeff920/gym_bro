import 'package:gym_bro/constants/enums.dart';

// Model to track 1-to-1 to database table
class ExerciseTable {
  final int id;
  final int workoutId;
  final int movementId;
  final int exerciseOrder;

  // duration is nullable because there are workouts without this column
  final String? duration;
  final int numWorkingSets;

  ExerciseTable(
      {required this.id,
      required this.workoutId,
      required this.movementId,
      required this.exerciseOrder,
      this.duration,
      required this.numWorkingSets});

  factory ExerciseTable.fromMap(Map<String, dynamic> map) {
    ExerciseTable generatedModel = ExerciseTable(
      id: map['id'],
      movementId: map['movement_id'],
      workoutId: map['workout_id'],
      exerciseOrder: map['exercise_order'],
      duration: map['duration'],
      numWorkingSets: map['num_working_sets'],
    );
    return generatedModel;
  }

  Map<String, dynamic> toMap() {
    return {
      'movement_id': movementId,
      'workout_id': workoutId,
      'exercise_order': exerciseOrder,
      'duration': duration.toString(),
      'numb_working_sets': numWorkingSets,
    };
  }
}

// ====================================================================
// ====================================================================

class ExerciseTableWithWorkedMuscleGroups extends ExerciseTable {
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  ExerciseTableWithWorkedMuscleGroups(
      {required super.id,
      required super.workoutId,
      required super.movementId,
      required super.exerciseOrder,
      super.duration,
      required super.numWorkingSets,
      required this.workedMuscleGroups});

  int getWorkingSetsPerMuscleGroup(MuscleGroupType muscleGroup) {
    return workedMuscleGroups.getWorkingSetsPerMuscleGroup(
        muscleGroup, numWorkingSets);
  }

  int calculateWorkingSetsPerMuscleGroup(MuscleGroupType muscleGroup) {
    return workedMuscleGroups.calculateWorkingSetsPerMuscleGroup(
        muscleGroup, numWorkingSets);
  }
}

class MovementWorkedMuscleGroupsType {
  final Map<MuscleGroupType, RoleType> workedMuscleGroupsMap;

  MovementWorkedMuscleGroupsType({required this.workedMuscleGroupsMap});

  // convert the object into a map, used mostly for saving state as json
  Map<String, String> toMap() {
    Map<String, String> typeAsMap = {};

    for (var entry in workedMuscleGroupsMap.entries) {
      typeAsMap[entry.key.name] = entry.value.name;
    }

    return typeAsMap;
  }

  // convert the object back from a map, used mostly for restoring state from json
  factory MovementWorkedMuscleGroupsType.fromMap({required Map<String, dynamic> map}) {
    Map<MuscleGroupType, RoleType> workedMuscleGroupsMap = {};

    for (var entry in map.entries) {
      workedMuscleGroupsMap[MuscleGroupType.values.byName(entry.key)] =
          RoleType.values.byName(entry.value);
    }

    return MovementWorkedMuscleGroupsType(workedMuscleGroupsMap: workedMuscleGroupsMap);
  }

  // For a movement this method returns all the primary muscle groups involved
  List<MuscleGroupType> returnPrimaryMuscleGroups() {
    List<MuscleGroupType> primaryMuscleGroups = [];
    for (var muscleGroup in workedMuscleGroupsMap.entries) {
      if (muscleGroup.value == RoleType.primary) {
        primaryMuscleGroups.add(muscleGroup.key);
      }
    }
    return primaryMuscleGroups;
  }

  // For a movement this method returns all the secondary muscle groups involved
  List<MuscleGroupType> returnSecondaryMuscleGroups() {
    List<MuscleGroupType> primaryMuscleGroups = [];
    for (var muscleGroup in workedMuscleGroupsMap.entries) {
      if (muscleGroup.value == RoleType.secondary) {
        primaryMuscleGroups.add(muscleGroup.key);
      }
    }
    return primaryMuscleGroups;
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
      return (workingSets / 4).floor();
    }
    return 0;
  }
}
