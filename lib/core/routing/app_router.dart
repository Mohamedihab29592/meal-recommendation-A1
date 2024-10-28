import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/features/profile/presentation/screens/profile_screen.dart';
import 'package:meal_recommendations/features/splash_boarding/splash_screen.dart';

class AppRouter {

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.verifyOtp:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.favourite:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
