import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_recommendations/core/helpers/extensions.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_bloc.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_event.dart';
import 'package:meal_recommendations/features/favourite/presentation/controller/fav_meal_state.dart';
import 'package:meal_recommendations/features/favourite/presentation/widget/meal_card_fav.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundLightColor,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackgroundLightColor,
        leading: const Icon(Icons.menu, color: AppColors.primaryColor),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.06),
            child: const Icon(Icons.notifications, color: AppColors.primaryColor),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => GetIt.I<MealBloc>()..add(LoadFavoritesEvent()),
        child: BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            if (state is MealLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MealLoaded) {
              if (state.favorites.isEmpty) {
                return const Center(child: Text('No favorites found.'));
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.04,
                  horizontal: screenWidth * 0.06,
                ),
                child: ListView.separated(
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final meal = state.favorites[index];
                    return MealCard(
                      meal: meal,
                      onFavoritePressed: () async {
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId != null) {
                          context.read<MealBloc>().add(RemoveFavoriteEvent(id: meal.id, userId: userId));
                        }
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: screenHeight * 0.02);
                  },
                ),
              );
            } else if (state is MealError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Unexpected state.'));
          },
        ),
      ),
    );
  }
}
