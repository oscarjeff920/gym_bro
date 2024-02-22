import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'muscle_group_table_operations_event.dart';
part 'muscle_group_table_operations_state.dart';

class MuscleGroupTableOperationsBloc extends Bloc<MuscleGroupTableOperationsEvent, MuscleGroupTableOperationsState> {
  MuscleGroupTableOperationsBloc() : super(MuscleGroupTableOperationsInitial()) {
    on<MuscleGroupTableOperationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
