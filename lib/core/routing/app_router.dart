import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/features/splash_boarding/screens/on_boarding_screen.dart';


import '../../features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login BLoc.dart';

class AppRouter {

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {



      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (_) => GetIt.instance<LoginBloc>(),
              child: const LoginScreen(),
            );
          },
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
          builder: (_) => const Placeholder(),
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
    }
  }
}
