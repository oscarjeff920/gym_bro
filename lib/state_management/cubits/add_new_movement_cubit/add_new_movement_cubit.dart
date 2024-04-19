import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_new_movement_state.dart';

class AddNewMovementCubit extends Cubit<AddNewMovementInitState> {
  AddNewMovementCubit() : super(const AddNewMovementInitState());

  openAddNewMovementExpansionPanel() {
    emit(const AddNewMovementState());
  }

  closeAddNewMovementExpansionPanel() {
    emit(const AddNewMovementInitState());
  }

}