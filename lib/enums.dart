import 'dart:ui';

enum MuscleGroup {
  chest,
  shoulders,
  biceps,
  triceps,
  back,
  legs,
}

Map<MuscleGroup, Color> muscleGroupColours = {
  MuscleGroup.chest: const Color.fromRGBO(255, 80, 80, 1),
  MuscleGroup.biceps: const Color.fromRGBO(255, 140, 80, 1),
  MuscleGroup.triceps: const Color.fromRGBO(250, 250, 100, 1),
  MuscleGroup.legs: const Color.fromRGBO(60, 250, 100, 1),
  MuscleGroup.shoulders: const Color.fromRGBO(10, 200, 255, 1),
  MuscleGroup.back: const Color.fromRGBO(150, 150, 255, 1),
};