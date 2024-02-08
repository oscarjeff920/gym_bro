import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/the_app_bar_widget.dart';

import '../../../state_management/blocs/database_operations_bloc/database_operations_bloc.dart';
import '../../../state_management/blocs/database_operations_bloc/database_operations_state.dart';
import '../../widgets/home_page_widgets/new_workout_button_widget.dart';
import '../../widgets/home_page_widgets/workouts_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TheAppBar(
        hasBackButton: false,
      ),
      body: Stack(children: [
        BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
          return const WorkoutsList();
        }),
        Container(
            alignment: const Alignment(0, 0.8),
            child: const NewWorkoutButton()
        ),
      ]),
    );
  }
}
