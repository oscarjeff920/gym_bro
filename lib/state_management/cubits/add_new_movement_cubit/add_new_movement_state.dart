import 'package:equatable/equatable.dart';

class AddNewMovementState extends Equatable {
  final bool isNewMovementSelected;
  final bool showAnimatedChildren;

  const AddNewMovementState(
      {this.isNewMovementSelected = false, this.showAnimatedChildren = false});

  @override
  List<Object?> get props => [isNewMovementSelected, showAnimatedChildren];
}
