import '../../constants/enums.dart';

class Workout {
  final int? id;
  final DateTime date;
  final DateTime duration;
  final Map<MuscleGroupType, int> groupSets;

  const Workout(
      {this.id,
      required this.date,
      required this.duration,
      required this.groupSets});
}

class CurrentSet {
  final int? id;
  final bool? isWarmUp;
  final double? weight;
  final int? reps;
  final int? extraReps;
  final Duration? setDuration;
  final String? notes;

  const CurrentSet({
    this.id,
    this.isWarmUp,
    this.weight,
    this.reps,
    this.extraReps,
    this.setDuration,
    this.notes,
  });

  String? setDurationToString() {
    if (setDuration == null) return null;
    String minutes =
        setDuration!.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        setDuration!.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }

  // factory CurrentSet.fromGeneralExerciseSetModel(GeneralExerciseSetModel exerciseSet) {
  //   CurrentSet convertedModel = CurrentSet(
  //     id: exerciseSet.id,
  //     isWarmUp: exerciseSet.isWarmUp,
  //     weight: exerciseSet.weight,
  //     reps: exerciseSet.reps,
  //     extraReps: exerciseSet.extraReps,
  //     setDuration: exerciseSet.setDuration,
  //
  //   )
  // }
}
