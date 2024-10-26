import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class IngredientItem extends StatelessWidget {
  const IngredientItem({
    super.key,
    required this.ingredient,
  });

  final MealIngredient ingredient;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        // imageUrl: ingredients[index].imageUrl ?? '',
        imageUrl:
            'https://img.freepik.com/free-photo/different-varieties-kabab-served-with-grilled-eggplants-tomatoes_140725-8134.jpg?t=st=1729945680~exp=1729949280~hmac=4263d5514b20e8769010e757011c73a51448b6a425bf0271341b0552b7612767&w=740',
        imageBuilder: (_, image) => CircleAvatar(
          backgroundImage: image,
          radius: 16.r,
        ),
      ),
      title: Text(
        ingredient.name,
        style: AppTextStyles.font18BoldDarkBlue,
      ),
      trailing: Text(
        '${ingredient.pieces} pcs',
        style: AppTextStyles.font18Medium.copyWith(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
