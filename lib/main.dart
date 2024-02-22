import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/movement/movement_repository.dart';
import 'package:gym_bro/database/database_connector.dart';
import 'package:gym_bro/design/routing/router.dart';
import 'package:gym_bro/state_management/blocs/building_workout_bloc/building_workout_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_operations_bloc/database_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/movement_table_operations_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseHelper databaseHelper = DatabaseHelper();
  runApp(MyApp(appRouter: AppRouter(), databaseHelper: databaseHelper));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final DatabaseHelper databaseHelper;

  const MyApp({super.key, required this.appRouter, required this.databaseHelper});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DatabaseBloc()),
        BlocProvider(create: (context) => MovementTableOperationsBloc(movementRepository: MovementRepository(databaseHelper))),
        BlocProvider(create: (context) => OpenExerciseModalCubit()),
        BlocProvider(create: (context) => AddExerciseCubit()),
        BlocProvider(create: (context) => BuildingWorkoutBloc()),
        BlocProvider(create: (context) => SetTimerCubit()),
        BlocProvider(create: (context) => WorkoutTimerCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
