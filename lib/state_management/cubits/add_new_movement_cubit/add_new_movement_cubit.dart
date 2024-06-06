import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_new_movement_state.dart';

class AddNewMovementCubit extends Cubit<AddNewMovementState> {
  AddNewMovementCubit() : super(const AddNewMovementState());

  openAddNewMovementExpansionPanel() {
    emit(const AddNewMovementState(isNewMovementSelected: true));
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(const AddNewMovementState(
          isNewMovementSelected: true, showAnimatedChildren: true));
    });
  }

  closeAddNewMovementExpansionPanel() {
    emit(const AddNewMovementState());
  }

  typeMovementName(String? name) {
    emit(AddNewMovementState(
        isNewMovementSelected: true,
        showAnimatedChildren: true,
        movementName: name));
  }
}
