import 'dart:ui';

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

List<String> getExercises (MuscleGroupType? muscleGroup) {
  switch (muscleGroup) {
    case MuscleGroupType.chest:
      return [
        "Barbell Bench Press",
        "Dumbbell Bench Press",
        "Flies",
        "Dips",
      ];
    case MuscleGroupType.shoulders:
      return [
        "Standing Military Press",
        "Front Raises",
        "Lateral Raises",
        "Standing Reverse Flies",
      ];
    case MuscleGroupType.back:
      return [
        "Bent Over Rows",
        "Pull-ups",
        "Seated Rows",
      ];
    case MuscleGroupType.biceps:
      return [
        "Hammer Curls",
        "Preacher Machine",
        "Reverse Curls",
        "Reverse Grip Pull-ups",
      ];
    case MuscleGroupType.triceps:
      return [
        "Skull Crushers",
        "Tricep Extension",
        "Close Grip Bench Press",
      ];
    case MuscleGroupType.legs:
      [
        "Squats",
        "Leg Press",
        "Hip Thrusts",
        "Lunges",
        "Romanian Dead Lift",
        "Split Squat"
      ];
    case null:
      return [];
  }
  return [];
}

Map<MuscleGroupType, Color> muscleGroupColours = {
  MuscleGroupType.chest: const Color.fromRGBO(255, 80, 80, 1),
  MuscleGroupType.biceps: const Color.fromRGBO(255, 140, 80, 1),
  MuscleGroupType.triceps: const Color.fromRGBO(250, 250, 100, 1),
  MuscleGroupType.legs: const Color.fromRGBO(50, 245, 95, 1),
  MuscleGroupType.shoulders: const Color.fromRGBO(10, 200, 255, 1),
  MuscleGroupType.back: const Color.fromRGBO(150, 150, 255, 1),
};
