import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/layout/presentation/views/layout_view.dart';
import 'package:meal_recommendations/features/meal_details/presentation/views/meal_details_view.dart';
import 'package:meal_recommendations/features/auth/register/persentation/screens/otp_screen.dart';
import 'package:meal_recommendations/features/auth/register/persentation/screens/register_screen.dart';
import 'package:meal_recommendations/features/splash_boarding/screens/on_boarding_screen.dart';
import 'package:meal_recommendations/features/splash_boarding/screens/splash_screen.dart';
import '../../features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login BLoc.dart';
import '../../features/auth/Login_Screen/presenation/screens/LoginScreen.dart';
import '../../features/auth/register/persentation/controller/sign_up_bloc.dart';
import '../../features/auth/register/persentation/cubit/otp_auth_cubit.dart';


class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => di<UserBloc>(), child: RegisterScreen()),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (_) => di<LoginBloc>(),
              child: const LoginScreen(),
            );
          },
        );

      case Routes.verifyOtp:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<OtpAuthCubit>(
                create: (_) => OtpAuthCubit(), child: const OtpScreen()));

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
          builder: (_) => const OnboardingScreen(),
        );
    }
  }
}
