import 'package:equatable/equatable.dart';

import '../../../database/data_models.dart';
import '../../../enums.dart';

class AddExerciseState extends Equatable {
  final MuscleGroup? selectedMuscleGroup;
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
    weight: ${currentSet!.weight}\n
    reps: ${currentSet!.reps}\n
    isWarmUp: ${currentSet!.isWarmUp}\n
    notes: ${currentSet!.notes}
    """;
  }

  AddExerciseState copyWith(
      {MuscleGroup? selectedMuscleGroup, String? selectedExercise}) {
    return AddExerciseState(
      selectedMuscleGroup: selectedMuscleGroup ?? this.selectedMuscleGroup,
      selectedExercise: selectedExercise ?? this.selectedExercise,
      currentSet: currentSet,
      setsDone: setsDone,
    );
  }

  String muscleGroupToString() {
    String groupName = selectedMuscleGroup.toString().split(".")[1];
    String capitalizedGroupName =
        groupName[0].toUpperCase() + groupName.substring(1);

    return capitalizedGroupName;
  }

  @override
  List<Object?> get props =>
      [selectedMuscleGroup, selectedExercise, currentSet, setsDone];
}

// class AddExerciseState extends Equatable {
//   @override
//   List<Object?> get props => [];
//
//   AddExerciseState copyWith() {return AddExerciseState();}
// }
//
// class OpenedAddExerciseModalState extends AddExerciseState {
//
//   @override
//   OpenedAddExerciseModalState copyWith() {return OpenedAddExerciseModalState();}
// }
//
// class SelectedMuscleGroupState extends AddExerciseState {
//   final MuscleGroup selectedMuscleGroup;
//
//   SelectedMuscleGroupState({required this.selectedMuscleGroup});
//
//   String muscleGroupToString() {
//     String groupName = selectedMuscleGroup.toString().split(".")[1];
//     String capitalizedGroupName =
//         groupName[0].toUpperCase() + groupName.substring(1);
//
//     return capitalizedGroupName;
//   }
//
//   @override
//   SelectedMuscleGroupState copyWith({required MuscleGroup selectedMuscleGroup}) {
//     return SelectedMuscleGroupState(selectedMuscleGroup: selectedMuscleGroup);
//   }
//
//   @override
//   List<Object?> get props => [selectedMuscleGroup];
// }
//
// class SelectedExerciseState extends SelectedMuscleGroupState {
//   final String exerciseName;
//
//   SelectedExerciseState({
//     required super.selectedMuscleGroup,
//     required this.exerciseName,
//   });
//
//   @override
//   SelectedExerciseState copyWith(
//       {MuscleGroup? selectedMuscleGroup, required String exerciseName}) {
//     return SelectedExerciseState(
//         selectedMuscleGroup: selectedMuscleGroup ?? this.selectedMuscleGroup,
//         exerciseName: exerciseName);
//   }
//
//   @override
//   List<Object?> get props => [selectedMuscleGroup, exerciseName];
// }
//
// class AddingRepsToExerciseState extends SelectedExerciseState {
//   final List<Reps> reps;
//
//   AddingRepsToExerciseState({
//     required super.selectedMuscleGroup,
//     required super.exerciseName,
//     required this.reps,
//   });
//
//   @override
//   List<Object?> get props => [selectedMuscleGroup, exerciseName, reps];
// }
