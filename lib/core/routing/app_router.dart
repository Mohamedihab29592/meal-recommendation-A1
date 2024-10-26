import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/layout/presentation/views/layout_view.dart';
import 'package:meal_recommendations/features/meal_details/presentation/views/meal_details_view.dart';
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
          builder: (_) => const Placeholder(),
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.layout:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LayoutBloc>(
            create: (_) => di.get<LayoutBloc>(),
            child: const LayoutView(),
          ),
        );

      case Routes.mealDetails:
        final args = settings.arguments as Meal;
        return MaterialPageRoute(
          builder: (_) => MealDetailsView(meal: args),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
