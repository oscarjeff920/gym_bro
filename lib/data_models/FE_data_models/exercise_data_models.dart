import 'package:gym_bro/constants/enums.dart';
import 'exercise_set_data_models.dart';

// ignore: camel_case_types
class ExerciseModel_WorkoutPage {
  final int? id;
  final int exerciseOrder;
  final String movementName;
  final int movementId;
  final String exerciseTotalDuration;
  final int numWorkingSets;
  final MuscleGroupType primaryMuscleGroup;
  // final MuscleGroupType secondaryMuscleGroup;

  ExerciseModel_WorkoutPage(
      {required this.id,
      required this.exerciseOrder,
      required this.movementName,
      required this.movementId,
      required this.exerciseTotalDuration,
      required this.numWorkingSets,
      required this.primaryMuscleGroup,
      // required this.secondaryMuscleGroup
      });

  factory ExerciseModel_WorkoutPage.fromMap(Map<String, dynamic> map) {
    print(map);
    return ExerciseModel_WorkoutPage(
        id: map['id'],
        exerciseOrder: map['exercise_order'],
        movementName: map['name'],
        movementId: map['movement_id'],
        exerciseTotalDuration: map['duration'],
        numWorkingSets: map['num_working_sets'],
        primaryMuscleGroup:
            MuscleGroupType.values.byName(map['primary_muscle_group_name']),
        // secondaryMuscleGroup:
        //     MuscleGroupType.values.byName(map['secondary_muscle_group_name'])
    );
  }
}

// ignore: camel_case_types
class ExerciseModel_ExerciseModal {
  final MuscleGroupType muscleGroup;
  final dynamic movement;
  final int totalWorkingSets;
  final List<ExerciseSetModel_ExerciseModal> allExerciseSets;

  ExerciseModel_ExerciseModal(
      {required this.muscleGroup,
      required this.movement,
      required this.totalWorkingSets,
      required this.allExerciseSets});
}
