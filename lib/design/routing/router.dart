import 'package:flutter/material.dart';
import 'package:gym_bro/design/routing/pages/home_page.dart';
import 'package:gym_bro/design/routing/pages/workout_page.dart';
class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case "/new-workout-page":
        return MaterialPageRoute(
          builder: (_) => const WorkoutOverviewPage(),
        );
      default:
        return null;
    }
  }
}
