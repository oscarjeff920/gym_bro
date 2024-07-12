import 'package:gym_bro/constants/enums.dart';

class ExerciseTable {
  final int? id;
  final int movementId;
  final int workoutId;
  final int exerciseOrder;
  final String? duration;
  final int numWorkingSets;

  ExerciseTable(
      {this.id,
      required this.movementId,
      required this.workoutId,
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

class ExerciseTableWithWorkedMuscleGroups extends ExerciseTable {
  final MovementWorkedMuscleGroupsType workedMuscleGroups;

  ExerciseTableWithWorkedMuscleGroups(
      {super.id,
      required super.movementId,
      required super.workoutId,
      required super.exerciseOrder,
      required super.numWorkingSets,
      required this.workedMuscleGroups});

  int getWorkingSetsPerMuscleGroup(MuscleGroupType muscleGroup) {
    return workedMuscleGroups.getWorkingSetsPerMuscleGroup(
        muscleGroup, numWorkingSets);
  }
}

class MovementWorkedMuscleGroupsType {
  final Map<MuscleGroupType, RoleType> workedMuscleGroupsMap;

  MovementWorkedMuscleGroupsType({required this.workedMuscleGroupsMap});

  List<MuscleGroupType> returnPrimaryMuscleGroups() {
    List<MuscleGroupType> primaryMuscleGroups = [];
    for (var muscleGroup in workedMuscleGroupsMap.entries) {
      if (muscleGroup.value == RoleType.primary) {
        primaryMuscleGroups.add(muscleGroup.key);
      }
    }
    return primaryMuscleGroups;
  }

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
      if (workedMuscleGroupsMap[muscleGroup] == RoleType.primary) {
        return workingSets;
      }
      return (workingSets / 4).floor();
    }
    return 0;
  }
}
