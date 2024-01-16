import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../enums.dart';

class AddExerciseState extends Equatable {
  final MuscleGroup? selectedMuscleGroup;

  const AddExerciseState({required this.selectedMuscleGroup});

  @override
  List<Object?> get props => [selectedMuscleGroup];

  Color colourModalByPrimaryMuscle(MuscleGroup muscleGroup) {
    switch (muscleGroup) {
      case MuscleGroup.chest:
        return const Color.fromRGBO(255, 80, 80, 1);
      case MuscleGroup.biceps:
        return const Color.fromRGBO(255, 140, 80, 1);
      case MuscleGroup.triceps:
        return const Color.fromRGBO(250, 250, 100, 1);
      case MuscleGroup.legs:
        return const Color.fromRGBO(60, 250, 100, 1);
      case MuscleGroup.shoulders:
        return const Color.fromRGBO(10, 200, 255, 1);
      case MuscleGroup.back:
        return const Color.fromRGBO(150, 150, 255, 1);
    }
  }

  String? muscleGroupToString() {
    if (selectedMuscleGroup == null) {
      return null;
    }

    String groupName = selectedMuscleGroup.toString().split(".")[1];
    String capitalizedGroupName =
        groupName[0].toUpperCase() + groupName.substring(1);

    return capitalizedGroupName;
  }
}
