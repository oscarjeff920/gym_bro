import 'package:equatable/equatable.dart';

class OpenExerciseModalState extends Equatable {
  final bool isOpen;

  const OpenExerciseModalState({required this.isOpen});

  @override
  List<Object?> get props => [];
}

class ExerciseModalClosedState extends OpenExerciseModalState{
  const ExerciseModalClosedState({super.isOpen = false});
}

class ExerciseModalOpenedState extends OpenExerciseModalState{
  const ExerciseModalOpenedState({super.isOpen = true});
}