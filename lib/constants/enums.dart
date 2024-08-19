import 'package:flutter/material.dart';

enum RoleType {
  primary,
  secondary,
}

enum MuscleGroupType {
  chest,
  shoulders,
  biceps,
  core,
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

    case MuscleGroupType.core:
      return Icons.account_balance;

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

// current
Map<MuscleGroupType, Color> originalColours = {
  MuscleGroupType.chest: const Color.fromRGBO(255, 80, 80, 1),

  MuscleGroupType.shoulders: const Color.fromRGBO(10, 200, 255, 1),

  MuscleGroupType.biceps: const Color.fromRGBO(255, 140, 80, 1),

  MuscleGroupType.triceps: const Color.fromRGBO(240, 220, 100, 1),

  MuscleGroupType.back: const Color.fromRGBO(150, 150, 255, 1),

  MuscleGroupType.legs: const Color.fromRGBO(30, 225, 75, 1),
};

// Options:
// Soft Palette (ff8080-80e5e5-ffb866-8a75e6-ffee80-d38ddb-66e066)
Map<MuscleGroupType, Color> softPalette = {
  MuscleGroupType.chest: const Color.fromRGBO(255, 128, 128, 1),
  // Soft Red        (ff8080)
  MuscleGroupType.shoulders: const Color.fromRGBO(128, 229, 229, 1),
  // Soft Turquoise  (80e5e5)
  MuscleGroupType.biceps: const Color.fromRGBO(255, 184, 102, 1),
  // Soft Orange     (ffb866)
  MuscleGroupType.core: const Color.fromRGBO(211, 141, 219, 1),
  // Soft Orchid     (d38ddb)
  MuscleGroupType.triceps: const Color.fromRGBO(255, 238, 128, 1),
  // Soft Yellow     (ffee80)
  MuscleGroupType.back: const Color.fromRGBO(138, 117, 230, 1),
  // Soft Blue       (8a75e6)
  MuscleGroupType.legs: const Color.fromRGBO(102, 224, 102, 1),
  // Soft Green      (66e066)
};

// Slightly More Saturated Palette (ff6666-66d6d6-ffa547-785bd4-ffe066-c366c8-4ecb4e)
Map<MuscleGroupType, Color> moreSaturatedPalette = {
  MuscleGroupType.chest: const Color.fromRGBO(255, 102, 102, 1),
  // Slightly More Saturated Red (ff6666)
  MuscleGroupType.shoulders: const Color.fromRGBO(102, 214, 214, 1),
  // Slightly More Saturated Turquoise (66d6d6)
  MuscleGroupType.biceps: const Color.fromRGBO(255, 165, 71, 1),
  // Slightly More Saturated Orange (ffa547)
  MuscleGroupType.core: const Color.fromRGBO(197, 108, 200, 1),
// Slightly More Saturated Orchid (c366c8)
  MuscleGroupType.triceps: const Color.fromRGBO(255, 238, 102, 1),
  // Slightly More Saturated Yellow (ffe066)
  MuscleGroupType.back: const Color.fromRGBO(120, 91, 212, 1),
  // Slightly More Saturated Blue (785bd4)
  MuscleGroupType.legs: const Color.fromRGBO(78, 203, 78, 1),
  // Slightly More Saturated Green (4ecb4e)
};

// Sporty Palette (ff3b3b-00b2b2-ff8c00-6a4ae1-ffee00-a55fc8-4caf50)
Map<MuscleGroupType, Color> sportyPalette = {
  MuscleGroupType.chest: const Color.fromRGBO(255, 59, 59, 1),
  // Sporty Bold Red (ff3b3b)
  MuscleGroupType.shoulders: const Color.fromRGBO(0, 178, 178, 1),
  // Sporty Bold Turquoise (00b2b2)
  MuscleGroupType.biceps: const Color.fromRGBO(255, 140, 0, 1),
  // Sporty Bright Orange (ff8c00)
  MuscleGroupType.core: const Color.fromRGBO(165, 92, 200, 1),
// Sporty Vibrant Orchid (a55fc8)
  MuscleGroupType.triceps: const Color.fromRGBO(255, 234, 0, 1),
  // Sporty Bright Yellow (ffee00)
  MuscleGroupType.back: const Color.fromRGBO(106, 74, 225, 1),
  // Sporty Vibrant Blue (6a4ae1)
  MuscleGroupType.legs: const Color.fromRGBO(76, 175, 80, 1),
  // Sporty Vibrant Green (4caf50)
};

// Custom Palette (ff5656-5ec0e7-ffa547-f589c3-f6ef67-785bd4-4ecb4e)
Map<MuscleGroupType, Color> customPalette = {
  MuscleGroupType.chest: const Color.fromRGBO(255, 86, 86, 1),
  // Soft Red (ff5656)
  MuscleGroupType.shoulders: const Color.fromRGBO(94, 192, 231, 1),
  // Soft Turquoise (5ec0e7)
  MuscleGroupType.biceps: const Color.fromRGBO(255, 165, 71, 1),
  // Soft Orange (ffa547)
  MuscleGroupType.core: const Color.fromRGBO(245, 137, 195, 1),
  // Soft Pink (f589c3)
  MuscleGroupType.triceps: const Color.fromRGBO(246, 239, 103, 1),
  // Soft Yellow (f6ef67)
  MuscleGroupType.back: const Color.fromRGBO(120, 91, 212, 1),
  // Soft Purple (785bd4)
  MuscleGroupType.legs: const Color.fromRGBO(78, 203, 78, 1),
  // Soft Green (4ecb4e)
};

// originalColours
// softPalette
// moreSaturatedPalette
// sportyPalette
Map<MuscleGroupType, Color> muscleGroupColours = customPalette;
