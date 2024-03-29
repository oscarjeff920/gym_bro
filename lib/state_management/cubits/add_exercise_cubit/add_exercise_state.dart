import 'package:equatable/equatable.dart';

import '../../../FE_consts/flutter_data_models.dart';
import '../../../FE_consts/enums.dart';

class AddExerciseState extends Equatable {
  final MuscleGroupType? selectedMuscleGroup;
  final String? selectedExercise;
  final CurrentSet? currentSet;
  final List<Sets> setsDone;

  const AddExerciseState(
      {required this.selectedMuscleGroup,
      required this.selectedExercise,
      this.currentSet,
      required this.setsDone});

  @override
  toString() {
    if (currentSet == null) {
      return """
      selected muscleGroup: $selectedMuscleGroup\n
      selected exercise: $selectedExercise\n
      There is no current set.
      """;
    }
    return """
    selected muscleGroup: $selectedMuscleGroup\n
    selected exercise: $selectedExercise\n
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
      selectedExercise: selectedExercise ?? this.selectedExercise,
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
      [selectedMuscleGroup, selectedExercise, currentSet, setsDone];
}
