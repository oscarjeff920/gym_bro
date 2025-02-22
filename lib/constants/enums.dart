import 'package:flutter/material.dart';

enum RoleType {
  primary,
  secondary,
}

class MuscleGroup {
  final MuscleGroupType type;
  final String title;
  final IconData icon;
  final Color colour;

  const MuscleGroup({
    required this.type,
    required this.title,
    required this.icon,
    required this.colour,
  });

  // Static Map to hold all muscle groups for easy iteration
  static final Map<MuscleGroupType, MuscleGroup> allMuscleGroups = {
    MuscleGroupType.chest: const MuscleGroup(
      type: MuscleGroupType.chest,
      title: "Chest",
      icon: Icons.favorite_outline_sharp,
      colour: Color.fromRGBO(255, 80, 80, 1),
    ),
    MuscleGroupType.shoulders: const MuscleGroup(
      type: MuscleGroupType.shoulders,
      title: "Shoulders",
      icon: Icons.emoji_people,
      colour: Color.fromRGBO(10, 200, 255, 1),
    ),
    MuscleGroupType.biceps: const MuscleGroup(
      type: MuscleGroupType.biceps,
      title: "Biceps",
      icon: Icons.fitness_center,
      colour: Color.fromRGBO(255, 140, 80, 1),
    ),
    MuscleGroupType.triceps: const MuscleGroup(
      type: MuscleGroupType.triceps,
      title: "Triceps",
      icon: Icons.expand,
      colour: Color.fromRGBO(240, 220, 100, 1),
    ),
    MuscleGroupType.back: const MuscleGroup(
      type: MuscleGroupType.back,
      title: "Back",
      icon: Icons.rowing,
      colour: Color.fromRGBO(150, 150, 255, 1),
    ),
    MuscleGroupType.legs: const MuscleGroup(
      type: MuscleGroupType.legs,
      title: "Legs",
      icon: Icons.sports_martial_arts,
      colour: Color.fromRGBO(30, 225, 75, 1),
    ),
  };
}

enum MuscleGroupType {
  chest,
  shoulders,
  biceps,
  triceps,
  back,
  legs,
}

enum SetType { comparison, current, completed }

enum TextFieldType { duration, text, number, bool }
