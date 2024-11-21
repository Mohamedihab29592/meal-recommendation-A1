import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/models/meal.dart';
import '../../../../../core/themes/app_colors.dart';

class BuildMealDetails extends StatelessWidget {
  const BuildMealDetails(
      {super.key, required this.meal, this.isLoading = false});
  final Meal meal;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.01),
        child: isLoading
            ? _buildShimmerPlaceholder(mediaQuery)
            : Column(
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
                      const Spacer(flex: 1),
                      Text(
                        "${meal.cookTime} min",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: mediaQuery.size.width * 0.043,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                  _buildRatingStars(meal.rating),
                ],
              ),
      ),
    );
  }

  Widget _buildShimmerPlaceholder(MediaQueryData mediaQuery) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: mediaQuery.size.width * 0.04,
            width: mediaQuery.size.width * 0.3,
            color: Colors.grey,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: mediaQuery.size.width * 0.055,
            width: mediaQuery.size.width * 0.5,
            color: Colors.grey,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Container(
                height: mediaQuery.size.width * 0.043,
                width: mediaQuery.size.width * 0.2,
                color: Colors.grey,
              ),
              const Spacer(flex: 1),
              Container(
                height: mediaQuery.size.width * 0.043,
                width: mediaQuery.size.width * 0.15,
                color: Colors.grey,
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: List.generate(5, (index) {
              return Container(
                margin: const EdgeInsets.only(right: 4),
                height: 18,
                width: 18,
                color: Colors.grey,
              );
            }),
          ),
        ),
      ],
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
