import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import '../widgets/build_ingredient_button.dart';
import '../widgets/build_search_bar.dart';
import '../widgets/build_top_bar.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = EdgeInsets.symmetric(
      vertical: mediaQuery.size.height * 0.02,
      horizontal: mediaQuery.size.width * 0.04,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            const BuildTopBar(),
            SizedBox(height: mediaQuery.size.height * 0.02),
            const BuildSearchBar(),
            SizedBox(height: mediaQuery.size.height * 0.03),
            const BuildIngredientButton(),
            SizedBox(height: mediaQuery.size.height * 0.03),
            _buildTopRecipesHeader(context),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildRecipeList(mediaQuery),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRecipesHeader(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Top Recipes',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: mediaQuery.size.width * 0.06,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'See all',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: mediaQuery.size.width * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeList(MediaQueryData mediaQuery) {
    return SizedBox(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.5,
      child: const RecipeCard(),
    );
  }

// TODO THIS FUNCTION NOT COMPLETED AND IT WILL BE COMPLETED IN THE NEXT TASK.
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const ShowFilterMealsBottomSheet(),
    );
  }
}
