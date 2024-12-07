import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/data_models/database_data_models/joined_tables/movement-muscle_group/movement-muscle_group_methods.dart';

class AddExerciseState extends Equatable {
  final MuscleGroupType? selectedMuscleGroup;
  final MovementWorkedMuscleGroupsType? workedMuscleGroups;
  final String? selectedMovement;
  final int? selectedMovementId;
  final CurrentSet? currentSet;
  final List<GeneralExerciseSetModel> setsDone;
  final int numWorkingSets;

  const AddExerciseState(
      {required this.selectedMuscleGroup,
        required this.workedMuscleGroups,
      required this.selectedMovement,
      required this.selectedMovementId,
      this.currentSet,
      required this.setsDone,
      required this.numWorkingSets});

  @override
  toString() {
    String defaultMessage = "\nselected muscleGroup: $selectedMuscleGroup"
        "\nselected movement: $selectedMovement"
        "\nselected movementId: $selectedMovementId"
        "\nsets done: $setsDone"
        "\nnumb working sets: $numWorkingSets"
        "\n    ";
    if (currentSet == null) {
      return """
      $defaultMessage
      There is no current set.
      """;
    }
    return """
    $defaultMessage
    Current Set:\n
    isWarmUp: ${currentSet!.isWarmUp}\n
    weight: ${currentSet!.weight}\n
    reps: ${currentSet!.reps}\n
    extraReps: ${currentSet!.extraReps}\n,
    setDuration: ${currentSet!.setDuration}\n
    notes: ${currentSet!.notes}
    """;
  }

  AddExerciseState copyWith(
      {MuscleGroupType? muscleGroup,
      String? movementName,
      int? movementId,
      int? workingSets,
      MovementWorkedMuscleGroupsType? movementWorkedMuscleGroups}) {
    return AddExerciseState(
      selectedMuscleGroup: muscleGroup ?? selectedMuscleGroup,
      selectedMovement: movementName ?? selectedMovement,
      selectedMovementId: movementId ?? selectedMovementId,
      currentSet: currentSet,
      setsDone: setsDone,
      numWorkingSets: workingSets ?? numWorkingSets,
      workedMuscleGroups: movementWorkedMuscleGroups ?? workedMuscleGroups,
    );
  }

  @override
  List<Object?> get props => [
        selectedMuscleGroup,
        selectedMovement,
        selectedMovementId,
        currentSet,
        setsDone
      ];
}
