import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/widgets/the_app_bar_widget.dart';
import 'package:gym_bro/state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TheAppBar(
        hasBackButton: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
              child: TextButton(
                  style:
                      const ButtonStyle(elevation: WidgetStatePropertyAll(10)),
                  onPressed: () {
                    BlocProvider.of<WorkoutTableOperationsBloc>(context)
                        .workoutRepository
                        .exportDatabaseToDownloads();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Export Database To Downloads"),
                      Icon(Icons.backup_outlined)
                    ],
                  ))),
          Expanded(
              child: TextButton(
                  style:
                      const ButtonStyle(elevation: WidgetStatePropertyAll(10)),
                  onPressed: () {
                    BlocProvider.of<WorkoutTableOperationsBloc>(context)
                        .workoutRepository
                        .printDatabaseToStdin();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Offload Db Dump to Debug"),
                      Icon(Icons.print)
                    ],
                  ))),
          const Spacer(
            flex: 12,
          )
        ],
      ),
    );
  }
}
