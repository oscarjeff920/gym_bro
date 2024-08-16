import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';

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
