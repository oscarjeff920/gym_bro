import 'package:equatable/equatable.dart';

class AddNewMovementState extends Equatable {
  final bool isNewMovementSelected;
  final bool showAnimatedChildren;
  final String? movementName;

  const AddNewMovementState(
      {this.isNewMovementSelected = false,
      this.showAnimatedChildren = false,
      this.movementName});

  @override
  List<Object?> get props =>
      [isNewMovementSelected, showAnimatedChildren, movementName];
}
