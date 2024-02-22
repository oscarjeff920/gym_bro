import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exercise_table_operations_event.dart';
part 'exercise_table_operations_state.dart';

class ExerciseTableOperationsBloc extends Bloc<ExerciseTableOperationsEvent, ExerciseTableOperationsState> {
  ExerciseTableOperationsBloc() : super(ExerciseTableOperationsInitial()) {
    on<ExerciseTableOperationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
