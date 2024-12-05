import 'package:flutter/material.dart';

enum RoleType {
  primary,
  secondary,
}

class MuscleGroup {
  final MuscleGroupType type;
  final IconData icon;
  final Color color;

  const MuscleGroup({
    required this.type,
    required this.icon,
    required this.color,
  });

  // Static list to hold all muscle groups for easy iteration
  static final List<MuscleGroup> allMuscleGroups = [
    const MuscleGroup(
      type: MuscleGroupType.chest,
      icon: Icons.favorite_outline_sharp,
      color: Color.fromRGBO(255, 80, 80, 1),
    ),
    const MuscleGroup(
      type: MuscleGroupType.shoulders,
      icon: Icons.emoji_people,
      color: Color.fromRGBO(10, 200, 255, 1),
    ),
    const MuscleGroup(
      type: MuscleGroupType.biceps,
      icon: Icons.fitness_center,
      color: Color.fromRGBO(255, 140, 80, 1),
    ),
    const MuscleGroup(
      type: MuscleGroupType.triceps,
      icon: Icons.expand,
      color: Color.fromRGBO(240, 220, 100, 1),
    ),
    const MuscleGroup(
      type: MuscleGroupType.back,
      icon: Icons.rowing,
      color: Color.fromRGBO(150, 150, 255, 1),
    ),
    const MuscleGroup(
      type: MuscleGroupType.legs,
      icon: Icons.sports_martial_arts,
      color: Color.fromRGBO(30, 225, 75, 1),
    ),
  ];
}

enum MuscleGroupType {
  chest,
  shoulders,
  biceps,
  triceps,
  back,
  legs,
}

