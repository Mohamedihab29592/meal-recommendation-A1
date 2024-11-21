import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_bloc.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_event.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_state.dart';
import 'package:meal_recommendations/features/favourite/presentation/widget/meal_card_fav.dart';
import 'package:meal_recommendations/features/favourite/presentation/widget/meal_card_placeholder.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<FavMealBloc>()..add(FetchAndSaveFavMealsEvent()), // Initialize and trigger event
      child: BlocBuilder<FavMealBloc, FavMealState>(
        builder: (context, state) {
          if (state is FavMealLoading) {
             return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemCount: 10, // Number of shimmer items to show
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: MealCardPlaceholder(),
                  );
                },
              ),
            );
          } else if (state is FavMealLoaded) {
            if (state.meals.isEmpty) {
              return const Center(child: Text(AppStrings.noMeals));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: ListView.builder(
                itemCount: state.meals.length,
                itemBuilder: (context, index) {
                  final meal = state.meals[index];
                  return MealCard(
                    meal: meal,
                  );
                },
              ),
            );
          } else if (state is FavMealError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(AppStrings.noMealsAvailable));
          }
        },
      ),
    );
  }
}
