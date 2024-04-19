import 'package:equatable/equatable.dart';

class AddNewMovementInitState extends Equatable {
  final bool isNewMovementSelected;

  const AddNewMovementInitState({this.isNewMovementSelected = false});

  @override
  List<Object?> get props => [isNewMovementSelected];
}

class AddNewMovementState extends AddNewMovementInitState {
  @override
  final bool isNewMovementSelected;

  const AddNewMovementState({this.isNewMovementSelected = true});
}
