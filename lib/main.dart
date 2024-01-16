import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/design/routing/router.dart';
import 'package:gym_bro/state_management/blocs/database_operations_bloc/database_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_operations_bloc/database_operations_event.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => DatabaseBloc()..add(StartUpDatabaseEvent())),
        BlocProvider(
            create: (context) => AddExerciseCubit()),
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

