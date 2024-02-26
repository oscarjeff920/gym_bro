import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/the_app_bar_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_event.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_state.dart';

import '../../widgets/home_page_widgets/new_workout_button_widget.dart';
import '../../widgets/home_page_widgets/workouts_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // sending this event at the top of the build so that whenever the user returns to the page a new request is sent
    // displaying any changes that may've been made / new completed workouts, instead of just when the app started up
    BlocProvider.of<WorkoutTableOperationsBloc>(context)
        .add(QueryAllWorkoutTableEvent());

    return Scaffold(
      appBar: const TheAppBar(
        hasBackButton: false,
      ),
      backgroundColor: Colors.grey,
      body: Stack(children: [
        BlocBuilder<WorkoutTableOperationsBloc, WorkoutTableOperationsState>(
            builder: (context, state) {
          switch (state) {
            case WorkoutTableSuccessfulQueryAllState():
              return WorkoutsList(
                  allWorkouts: state.convertWorkoutsForHomePage());
            default:
              return Container();
          }
        }),
        Container(
            alignment: const Alignment(0, 0.8),
            child: const NewWorkoutButton()),
      ]),
    );
  }
}
