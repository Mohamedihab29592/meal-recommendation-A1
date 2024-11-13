import 'package:firebase_auth/firebase_auth.dart';
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
import '../../features/SeeAllScreen/domain/repositories/BaseSeeAllRepository.dart';
import '../../features/SeeAllScreen/presentation/controller/Bloc/SeeAll BLoc.dart';
import '../../features/SeeAllScreen/presentation/controller/State/SeeAll events.dart';
import '../../features/SeeAllScreen/presentation/screens/SeeAllScreen.dart';
import '../../features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login BLoc.dart';
import '../../features/auth/Login_Screen/presenation/screens/LoginScreen.dart';
import '../../features/auth/register/persentation/controller/sign_up_bloc.dart';
import '../../features/auth/register/persentation/cubit/otp_auth_cubit.dart';

import '../../features/favourite/presentation/screens/favourite_screen.dart';
import '../../features/home/businessLogic/meal_cubit.dart';
import '../../features/home/data/data_source.dart';
import '../../features/home/persentation/HomeScreen/home_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/sidebar/presentation/controller/bloc/side_bloc.dart';

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

      case Routes:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      MealCubit(FirebaseService())..fetchMeals(),
                  child: const HomeScreen(),
                ));

      case Routes.favourite:
        return MaterialPageRoute(
          builder: (_) => const FavouriteScreen(),
        );

      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) =>
              ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.layout:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => di<SideBarBloc>()),
                  BlocProvider<LayoutBloc>(
                    create: (_) => di.get<LayoutBloc>(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        MealCubit(FirebaseService())..fetchMeals(),
                  )
                ], child: const LayoutView()));

      case Routes.mealDetails:
        final args = settings.arguments as Meal;
        return MaterialPageRoute(
          builder: (_) => MealDetailsView(meal: args),
        );
      case Routes.seeAll:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SeeAllBloc(di<BaseSeeAllRepository>())..add(FetchTrendingRecipesEvent()),
            child: SeeAllScreen(seeAllRepository: di<BaseSeeAllRepository>()),
          ),
        );


      default:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
    }
  }
}
