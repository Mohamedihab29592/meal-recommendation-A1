import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/meal.dart';
import '../../../../core/themes/app_text_styles.dart';

class RecommendedRecipesItem extends StatelessWidget {
    RecommendedRecipesItem({super.key, required this.meal});
   Meal meal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffDEDEDE), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 2.1 / 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image:  DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(meal.imageUrl!),
                  ),
                ),
              ),
            ),
          ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${meal.dishName}',
              style: AppTextStyles.font21BoldDarkBlue,
            ),
          ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  '${meal.ingredients?.length} ingredients',
                  style: AppTextStyles.font15MediumBlueGrey,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '${meal.cookTime}mins',
                  style: AppTextStyles.font16Regular,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [

                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
