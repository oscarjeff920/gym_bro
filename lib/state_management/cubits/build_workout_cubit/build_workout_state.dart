import 'package:equatable/equatable.dart';

class BuildWorkoutState extends Equatable {

  const BuildWorkoutState();

  @override
  List<Object?> get props => [];
}

class NewWorkoutState extends BuildWorkoutState {
  final DateTime date;

  const NewWorkoutState({required this.date});

  @override
  List<Object?> get props => [date];
}