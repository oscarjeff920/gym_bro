import 'package:flutter/material.dart';
import 'package:gym_bro/design/routing/pages/home_page.dart';
import 'package:gym_bro/design/routing/pages/loading_exercises_page.dart';
import 'package:gym_bro/design/routing/pages/workout_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case "/workout-page":
        return MaterialPageRoute(
          builder: (_) => const WorkoutOverviewPage(),
        );
      case "/loading-exercises-page:":
        return MaterialPageRoute(
          builder: (_) => const LoadingExercisesPage(),
        );
      default:
        return null;
    }
  }
}
