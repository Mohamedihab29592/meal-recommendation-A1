import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/helpers/extensions.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/features/favourite/data/models/meal.dart';

class MealCard extends StatelessWidget {
  final FavMealModel meal;
  final VoidCallback onFavoritePressed;

  const MealCard({
    super.key,
    required this.meal,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
      padding: EdgeInsets.all(screenWidth * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: screenWidth * 0.003,
        ),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: screenWidth * 0.005,
            blurRadius: screenWidth * 0.015,
            offset: Offset(0, screenHeight * 0.005),
          ),
        ],
      ),
      width: screenWidth * 0.9,
      height: screenHeight * 0.18,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListTile(
              leading: CircleAvatar(
                radius: screenWidth * 0.08,
                foregroundImage: NetworkImage(meal.imageUrl),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.dishName,
                    style: AppTextStyles.font15MediumGrey.copyWith(
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  Text(
                    meal.title,
                    style: AppTextStyles.font20Bold.copyWith(
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${meal.noOfIngredients} ingredients',
                        style: AppTextStyles.font15MediumGrey.copyWith(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      Text(
                        meal.noHours,
                        style: AppTextStyles.font15MediumBlueGrey.copyWith(
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                  RatingBar(
                    size: screenWidth * 0.05,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    onRatingChanged: (value) => debugPrint('$value'),
                    initialRating: meal.rating,
                    maxRating: 5,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: onFavoritePressed,
              icon: Icon(
                meal.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: AppColors.primaryColor,
                size: screenWidth * 0.07,
              ),
            ),
          ),
        ],
      ),
    );
  }
}