import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/helpers/extensions.dart';

class MealDetailsImage extends StatelessWidget {
  const MealDetailsImage({
    super.key,
    required this.mealImageUrl,
  });

  final String mealImageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: mealImageUrl,
      errorWidget: (_, __, ___) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
      fit: BoxFit.cover,
      width: double.infinity,
      height: context.screenHeight * 0.3,
    );
  }
}
