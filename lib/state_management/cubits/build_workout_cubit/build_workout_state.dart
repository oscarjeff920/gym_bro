import 'package:equatable/equatable.dart';

import '../add_exercise_cubit/add_exercise_state.dart';

class BuildWorkoutState extends Equatable {
  final List<AddExerciseState> exercises;

  const BuildWorkoutState({required this.exercises});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  // BuildWorkoutState copyWith({AddExerciseState? exercise}) {
  //   return BuildWorkoutState(exercises: exercise ?? exercises)
}