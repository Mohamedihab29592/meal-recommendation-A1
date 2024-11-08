import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/favorite_bloc.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/favorite_event.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/favorite_state.dart';
import 'package:meal_recommendations/features/favourite/presentation/widget/meal_card_fav.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            if (state.favoriteMeals.isEmpty) {
              return const Center(child: Text('No favorite meals'));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20 , left: 15 , right: 15),
              child: ListView.builder(
                itemCount: state.favoriteMeals.length,
                itemBuilder: (context, index) {
                  final meal = state.favoriteMeals[index];
                  return MealCard(
                    meal: meal,
                    onFavoritePressed: () {
                      final favoriteBloc = context.read<FavoriteBloc>();
                      if (meal.isFavourite) {
                        favoriteBloc.add(RemoveFavorite(meal));
                      } else {
                        favoriteBloc.add(FetchFavorites());
                      }
                    },
                  );
                },
              ),
            );
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No favorites available.'));
          }
        },
      ),
    );
  }
}
