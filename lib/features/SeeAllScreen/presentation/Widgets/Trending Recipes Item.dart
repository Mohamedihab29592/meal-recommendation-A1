import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/meal.dart';
import '../../../../core/themes/app_text_styles.dart';

class TrendingRecipesItem extends StatelessWidget {
  TrendingRecipesItem({super.key, required this.meal});
  Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.14,
          child: AspectRatio(
            aspectRatio: 2.1 / 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(meal.imageUrl!)),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${meal.dishName}',
            style: AppTextStyles.font21BoldDarkBlue,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                '${meal.ingredients?.length} ingredients',
                style:AppTextStyles.font14Regular.copyWith(fontSize: 12.sp),
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                '${meal.cookTime}mins',
                style: AppTextStyles.font15MediumBlueGrey.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
