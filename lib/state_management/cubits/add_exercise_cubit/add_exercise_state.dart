import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';


class AddExerciseState extends Equatable {
  final MuscleGroupType? selectedMuscleGroup;
  final String? selectedMovement;
  final CurrentSet? currentSet;
  final List<Sets> setsDone;

  const AddExerciseState(
      {required this.selectedMuscleGroup,
      required this.selectedMovement,
      this.currentSet,
      required this.setsDone});

  @override
  toString() {
    if (currentSet == null) {
      return """
      selected muscleGroup: $selectedMuscleGroup\n
      selected exercise: $selectedMovement\n
      There is no current set.
      """;
    }
    return """
    selected muscleGroup: $selectedMuscleGroup\n
    selected exercise: $selectedMovement\n
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
      {MuscleGroupType? selectedMuscleGroup, String? selectedExercise}) {
    return AddExerciseState(
      selectedMuscleGroup: selectedMuscleGroup ?? this.selectedMuscleGroup,
      selectedMovement: selectedExercise ?? this.selectedMovement,
      currentSet: currentSet,
      setsDone: setsDone,
    );
  }

  String? muscleGroupToString() {
    if (selectedMuscleGroup == null){
      return null;
    }
    String groupName = selectedMuscleGroup.toString().split(".")[1];
    String capitalizedGroupName =
        groupName[0].toUpperCase() + groupName.substring(1);

    return capitalizedGroupName;
  }

  @override
  List<Object?> get props =>
      [selectedMuscleGroup, selectedMovement, currentSet, setsDone];
}
