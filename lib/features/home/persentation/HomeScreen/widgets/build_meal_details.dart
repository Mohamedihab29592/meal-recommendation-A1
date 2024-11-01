import 'package:flutter/material.dart';

import '../../../../../core/models/meal.dart';
import '../../../../../core/themes/app_colors.dart';
class BuildMealDetails extends StatelessWidget {
  const BuildMealDetails({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return       Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meal.mealType!,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                fontSize: mediaQuery.size.width * 0.04,
              ),
            ),
            Text(
              meal.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: mediaQuery.size.width * 0.055,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            Row(
              children: [
                Text(
                  "${meal.ingredients!.length} ingredients",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: mediaQuery.size.width * 0.043,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  "${meal.cookTime} min",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: mediaQuery.size.width * 0.043,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
            _buildRatingStars(meal.rating),
          ],
        ),
      ),
    );

  }

  Widget _buildRatingStars(double? rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index + 1 <= rating!.toInt()) {
          return const Icon(Icons.star, color: Colors.amber, size: 18);
        } else if (index + 0.5 < rating.toInt()) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 18);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 18);
        }
      }),
    );
  }
}
