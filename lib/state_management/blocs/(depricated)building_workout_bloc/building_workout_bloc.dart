
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'building_workout_event.dart';
part 'building_workout_state.dart';

class BuildingWorkoutBloc extends Bloc<BuildingWorkoutEvent, BuildingWorkoutState> {
  BuildingWorkoutBloc() : super(BuildingWorkoutInitial()) {
    on<BuildingWorkoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
