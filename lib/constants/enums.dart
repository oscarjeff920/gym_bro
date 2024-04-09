import 'package:flutter/material.dart';

enum RoleType {
  primary,
  secondary,
}

enum MuscleGroupType {
  chest,
  shoulders,
  biceps,
  triceps,
  back,
  legs,
}

IconData assignIcon(MuscleGroupType muscleGroup) {
  switch (muscleGroup) {
    case MuscleGroupType.chest:
      return Icons.favorite_outline_sharp;
    case MuscleGroupType.shoulders:
      return Icons.emoji_people;
    case MuscleGroupType.biceps:
      return Icons.fitness_center;
    case MuscleGroupType.triceps:
      return Icons.expand;
    case MuscleGroupType.back:
      return Icons.rowing;
    case MuscleGroupType.legs:
      return Icons.sports_martial_arts;
    default:
      return Icons.question_mark;
  }
}

Map<MuscleGroupType, Color> muscleGroupColours = {
  MuscleGroupType.chest: const Color.fromRGBO(255, 80, 80, 1),
  MuscleGroupType.biceps: const Color.fromRGBO(255, 140, 80, 1),
  MuscleGroupType.triceps: const Color.fromRGBO(240, 220, 100, 1),
  MuscleGroupType.legs: const Color.fromRGBO(50, 245, 95, 1),
  MuscleGroupType.shoulders: const Color.fromRGBO(10, 200, 255, 1),
  MuscleGroupType.back: const Color.fromRGBO(150, 150, 255, 1),
};
