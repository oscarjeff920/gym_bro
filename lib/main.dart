import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/database/database_repositories/exercise_set_repository.dart';
import 'package:gym_bro/database/database_repositories/movement_repository.dart';
import 'package:gym_bro/database/database_connector.dart';
import 'package:gym_bro/design/routing/router.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/movement/get_movement_by_muscle_group/movement_get_by_muscle_group_bloc.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';
import 'package:gym_bro/state_management/cubits/save_error_state_cubit/save_error_state_cubit.dart';
import 'package:gym_bro/state_management/cubits/set_timer_cubit/set_timer_cubit.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';

import 'database/database_repositories/exercise_repository.dart';
import 'database/database_repositories/workout_repository.dart';
import 'state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'state_management/blocs/database_tables/exercise_set/exercise_set_table_operations_bloc.dart';
import 'state_management/blocs/database_tables/movement/get_movement_name_by_id/movement_get_name_by_id_bloc.dart';
import 'state_management/blocs/database_tables/workout/workout_table_operations_bloc.dart';
import 'state_management/cubits/backup_current_workout_cubit/backup_current_workout_cubit.dart';
import 'state_management/cubits/toggle_workout_week_widget_cubit/toggle_workout_week_widget_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseHelper databaseHelper = DatabaseHelper();
  runApp(MyApp(appRouter: AppRouter(), databaseHelper: databaseHelper));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final DatabaseHelper databaseHelper;

  const MyApp(
      {super.key, required this.appRouter, required this.databaseHelper});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BLoCs
        // Workout Table BLoCs
        BlocProvider(
            create: (context) => WorkoutTableOperationsBloc(
                workoutRepository: WorkoutRepository(databaseHelper))),
        // Muscle Group Table BLoCs
        BlocProvider(
            create: (context) => MovementByMuscleGroupBloc(
                movementRepository: MovementRepository(databaseHelper))),
        // Exercise Table BLoCs
        BlocProvider(
            create: (context) => ExerciseTableOperationsBloc(
                exerciseRepository: ExerciseRepository(databaseHelper))),
        // Exercise Set Table BLoCs
        BlocProvider(
            create: (context) => ExerciseSetTableOperationsBloc(
                exerciseSetRepository: ExerciseSetRepository(databaseHelper))),
        BlocProvider(
            create: (context) => GetLastExerciseSetsByMovementBloc(
                exerciseSetRepository: ExerciseSetRepository(databaseHelper))),
        // Movement Table BLoCs
        BlocProvider(
            create: (context) => MovementGetNameByIdBloc(
                movementRepository: MovementRepository(databaseHelper))),

        // Cubits
        BlocProvider(create: (context) => ActiveWorkoutCubit()),
        BlocProvider(create: (context) => OpenExerciseModalCubit()),
        BlocProvider(create: (context) => AddExerciseCubit()),
        BlocProvider(create: (context) => ToggleWorkoutWeekWidgetCubit()),
        BlocProvider(create: (context) => SetTimerCubit()),
        BlocProvider(create: (context) => WorkoutTimerCubit()),
        BlocProvider(create: (context) => DisplayPrCubit()),
        BlocProvider(create: (context) => AddNewMovementCubit()),
        BlocProvider(
            create: (context) =>
                BackupCurrentWorkoutCubit()..loadBackupState()),
        BlocProvider(create: (context) => SaveErrorStateCubit()),
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
