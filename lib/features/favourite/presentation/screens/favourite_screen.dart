import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/services/di.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_bloc.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_event.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_state.dart';
import 'package:meal_recommendations/features/favourite/presentation/widget/meal_card_fav.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<FavMealBloc>()..add(FetchAndSaveFavMealsEvent()), // Initialize and trigger event
      child: BlocBuilder<FavMealBloc, FavMealState>(
        builder: (context, state) {
          if (state is FavMealLoading) {
            return const Center(child: CircularProgressIndicator());
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
                    onRemove: (){
                      context.read<FavMealBloc>().add(RemoveFavMealEvent(meal));

                    },
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
