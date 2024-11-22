import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/features/GeminiAi/Data/Repo/recipeRepo.dart';
import 'package:meal_recommendations/features/GeminiAi/Data/data_sorce/suggested_meal.dart';
import 'package:meal_recommendations/features/GeminiAi/Domain/UseCase/getRecipeSuggestionUseCase.dart';
import 'package:meal_recommendations/features/GeminiAi/Presentation/Screens/gemini_screen.dart';
import 'package:meal_recommendations/features/GeminiAi/Presentation/cubit/suggested_recipe_cubit.dart';
import 'package:meal_recommendations/features/home/data/local_data.dart';
import 'package:meal_recommendations/features/home/data/meal_repo_impl.dart';
import 'package:meal_recommendations/features/home/domain/usecase/add_meal_to_fav.dart';
import 'package:meal_recommendations/features/home/domain/usecase/fetch_meals.dart';
import 'package:meal_recommendations/features/home/domain/usecase/firestore_usecase.dart';
import 'package:meal_recommendations/features/home/domain/usecase/remove_meal.dart';
import 'package:meal_recommendations/features/home/domain/usecase/remove_meal_from_fireStore.dart';
import 'package:meal_recommendations/features/layout/presentation/blocs/layout_bloc.dart';
import 'package:meal_recommendations/features/layout/presentation/views/layout_view.dart';
import 'package:meal_recommendations/features/meal_details/presentation/views/meal_details_view.dart';
import 'package:meal_recommendations/features/auth/register/persentation/screens/otp_screen.dart';
import 'package:meal_recommendations/features/auth/register/persentation/screens/register_screen.dart';
import 'package:meal_recommendations/features/profile/presentation/screens/profile_screen.dart';
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
import '../../features/home/data/data_source.dart';
import '../../features/home/persentation/businessLogic/meal_cubit.dart';
import '../../features/home/persentation/screens/home_screen.dart';
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
        return _loginRoute();

      case Routes.verifyOtp:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<OtpAuthCubit>(
                create: (_) => OtpAuthCubit(), child: const OtpScreen()));

      // case Routes.home:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) => MealCubit(
      //                 fetchMealsUseCase: FetchMeals(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 addMealToFavoritesUseCase: AddMealToFav(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 removeFavoriteMealUseCase: RemoveMeal(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 updateIsFavUseCase: UpdateIsFavInFirestore(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 removeMealFromFirestore: RemoveMealFromFirestore(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 localData: LocalData())
      //               ..fetchMeals(),
      //             child: const HomeScreen(),
      //           ));

      case Routes.favourite:
        return MaterialPageRoute(
          builder: (_) => const FavoriteScreen(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.layout:
        return _layoutRoute();

      case Routes.mealDetails:
        final args = settings.arguments as Meal;
        return MaterialPageRoute(
          builder: (_) => MealDetailsView(meal: args),
        );
      case Routes.seeAll:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SeeAllBloc(di<BaseSeeAllRepository>())
              ..add(FetchTrendingRecipesEvent()),
            child: SeeAllScreen(seeAllRepository: di<BaseSeeAllRepository>()),
          ),
        );

      case Routes.mealSuggestion:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<SuggestedRecipeCubit>(
                    create: (_) => SuggestedRecipeCubit(
                        GetRecipeSuggestionUseCase(
                            RecipeRepository(RecipeRemoteDatasource()))),
                  ),
                  BlocProvider<MealCubit>(
                    create: (_) => MealCubit(
                        fetchMealsUseCase: FetchMeals(
                            MealRepositoryImpl(FirebaseService(), LocalData())),
                        addMealToFavoritesUseCase: AddMealToFav(
                            MealRepositoryImpl(FirebaseService(), LocalData())),
                        removeFavoriteMealUseCase: RemoveMeal(
                            MealRepositoryImpl(FirebaseService(), LocalData())),
                        updateIsFavUseCase: UpdateIsFavInFirestore(
                            MealRepositoryImpl(FirebaseService(), LocalData())),
                        removeMealFromFirestore: RemoveMealFromFirestore(
                            MealRepositoryImpl(FirebaseService(), LocalData())),
                        localData: LocalData()),
                  )
                ], child: MealSuggestionScreen()));

      default:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
    }
  }

  static MaterialPageRoute<dynamic> _loginRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => di<LoginBloc>(),
          child: const LoginScreen(),
        );
      },
    );
  }

  static MaterialPageRoute<dynamic> _layoutRoute() {
    return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
              BlocProvider(create: (context) => SideBarBloc(di())),
              BlocProvider<LayoutBloc>(
                create: (_) => di.get<LayoutBloc>(),
              ),
              BlocProvider(
                create: (context) => MealCubit(
                    fetchMealsUseCase: FetchMeals(
                        MealRepositoryImpl(FirebaseService(), LocalData())),
                    addMealToFavoritesUseCase: AddMealToFav(
                        MealRepositoryImpl(FirebaseService(), LocalData())),
                    removeFavoriteMealUseCase: RemoveMeal(
                        MealRepositoryImpl(FirebaseService(), LocalData())),
                    updateIsFavUseCase: UpdateIsFavInFirestore(
                        MealRepositoryImpl(FirebaseService(), LocalData())),
                    removeMealFromFirestore: RemoveMealFromFirestore(
                        MealRepositoryImpl(FirebaseService(), LocalData())),
                    localData: LocalData())
                  ..fetchMeals(),
              )
            ], child: const LayoutView()));
  }
}
