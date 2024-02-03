import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_bro/enums.dart';

enum MuscleGroup {
  chest,
  shoulders,
  biceps,
  triceps,
  back,
  legs,
}

IconData assignIcon(MuscleGroup muscleGroup) {
  switch (muscleGroup) {
    case MuscleGroup.chest:
      return Icons.favorite_outline_sharp;
    case MuscleGroup.shoulders:
      return Icons.emoji_people;
    case MuscleGroup.biceps:
      return Icons.fitness_center;
    case MuscleGroup.triceps:
      return Icons.expand;
    case MuscleGroup.back:
      return Icons.rowing;
    case MuscleGroup.legs:
      return Icons.sports_martial_arts;
    default:
      return Icons.question_mark;
  }
}


Map<MuscleGroup, Color> muscleGroupColours = {
  MuscleGroup.chest: const Color.fromRGBO(255, 80, 80, 1),
  MuscleGroup.biceps: const Color.fromRGBO(255, 140, 80, 1),
  MuscleGroup.triceps: const Color.fromRGBO(250, 250, 100, 1),
  MuscleGroup.legs: const Color.fromRGBO(50, 245, 95, 1),
  MuscleGroup.shoulders: const Color.fromRGBO(10, 200, 255, 1),
  MuscleGroup.back: const Color.fromRGBO(150, 150, 255, 1),
};