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
  final Map<MuscleGroupType, RoleType> workedMuscleGroups;

  ExerciseTableWithWorkedMuscleGroups(
      {super.id,
      required super.movementId,
      required super.workoutId,
      required super.exerciseOrder,
      required super.numWorkingSets,
      required this.workedMuscleGroups});

  int getWorkingSetsPerMuscleGroup(MuscleGroupType muscleGroup) {
    if (workedMuscleGroups.containsKey(muscleGroup)) {
      if (workedMuscleGroups[muscleGroup] == RoleType.primary) {
        return numWorkingSets;
      }
      return (numWorkingSets/2).floor();
    }
    return 0;
  }
}
