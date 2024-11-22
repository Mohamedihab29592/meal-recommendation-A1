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
    print(ingredient.imageUrl);
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: ingredient.imageUrl,
        imageBuilder: (_, image) => CircleAvatar(
          backgroundImage: image,
          radius: 16.r,
        ),
        placeholder: (_, __) => CircleAvatar(
          radius: 16.r,
          backgroundColor: Colors.grey[300],
        ),
        errorWidget: (_, __, ___) => CircleAvatar(
          radius: 16.r,
          backgroundColor: Colors.red,
          child: Icon(Icons.error, size: 16.r),
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
