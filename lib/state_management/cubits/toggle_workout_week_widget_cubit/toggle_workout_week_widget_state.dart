import 'package:equatable/equatable.dart';

class ToggleWorkoutWeekWidgetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleWorkoutWeekWidgetInitState extends ToggleWorkoutWeekWidgetState {}

class ToggleWorkoutWeekWidgetLoadedWeeksState
    extends ToggleWorkoutWeekWidgetState {
  final List<bool> isExpandedArray;

  ToggleWorkoutWeekWidgetLoadedWeeksState({required this.isExpandedArray});

  @override
  List<Object?> get props => [isExpandedArray];

// ToggleWorkoutWeekWidgetLoadedWeeksState copyWith({int index}) {
//
// }
}
