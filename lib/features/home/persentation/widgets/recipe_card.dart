import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import '../../../../../core/models/meal.dart';
import '../../../../../core/themes/app_colors.dart';
import '../businessLogic/meal_cubit.dart';
import 'build_meal_card.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return BlocConsumer<MealCubit, MealState>(
      listener: (context, state) {
        if (state is MealError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.primaryColor,
              content: Text(
                state.error,
                style:
                    AppTextStyles.font16Regular.copyWith(color: Colors.white),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MealLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is MealLoaded) {
          return state.meals.isEmpty
              ? const Center(child: Text('No meals available'))
              : _buildMealList(context, state.meals, mediaQuery);
        } else {
          return const Center(child: Text('Please wait...'));
        }
      },
    );
  }

  Widget _buildMealList(
      BuildContext context, List<Meal> meals, MediaQueryData mediaQuery) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) =>
          SizedBox(height: mediaQuery.size.height * 0.02),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return BuildMealCard(meal: meal);
      },
    );
  }
}
