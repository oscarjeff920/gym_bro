import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exercise_set_table_operations_event.dart';
part 'exercise_set_table_operations_state.dart';

class ExerciseSetTableOperationsBloc extends Bloc<ExerciseSetTableOperationsEvent, ExerciseSetTableOperationsState> {
  ExerciseSetTableOperationsBloc() : super(ExerciseSetTableOperationsInitial()) {
    on<ExerciseSetTableOperationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
