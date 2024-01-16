import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state_management/blocs/database_operations_bloc/database_operations_bloc.dart';
import '../../../state_management/blocs/database_operations_bloc/database_operations_state.dart';
import '../../widgets/home_page/new_workout_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Gym Brooo",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 20,
          backgroundColor: const Color.fromRGBO(230, 120, 50, 1),
        ),
        body: Stack(children: [
          BlocBuilder<DatabaseBloc, DatabaseState>(builder: (context, state) {
            return ListView();
          }),
          Column(
            children: [
              Expanded(flex: 6, child: Container()),
              const Expanded(
                flex: 1,
                child: Center(
                  child: NewWorkoutButton(),
                ),
              ),
              Expanded(flex: 1, child: Container())
            ],
          ),
        ]));
  }
}
