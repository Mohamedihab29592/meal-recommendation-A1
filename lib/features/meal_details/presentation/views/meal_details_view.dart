import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/utils/constant.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/meal_data_row.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/meal_details_image.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/meal_details_sliver_app_bar.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/meal_details_tab_bar.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/meal_details_tab_bar_view.dart';
import 'package:meal_recommendations/features/meal_details/presentation/widgets/meal_name.dart';

class MealDetailsView extends StatelessWidget {
  const MealDetailsView({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppConstants.mealDetailsTabs.length,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const MealDetailsSliverAppBar(),
              SliverToBoxAdapter(
                child: MealDetailsImage(
                  mealImageUrl: meal.imageUrl ??
                      'https://img.freepik.com/free-photo/different-varieties-kabab-served-with-grilled-eggplants-tomatoes_140725-8134.jpg?t=st=1729945680~exp=1729949280~hmac=4263d5514b20e8769010e757011c73a51448b6a425bf0271341b0552b7612767&w=740',
                ),
              ),
              SliverToBoxAdapter(
                // child: MealName(
                //   mealName: meal.name!,
                // ),
                child: MealName(mealName: meal.name ?? 'Unknown Meal'),
              ),
              SliverToBoxAdapter(
                child: MealDataRow(
                  mealDishName: meal.dishName!,
                  mealCookTime: meal.cookTime!,
                  mealServingSize: meal.servingSize!,
                ),
              ),
              const SliverToBoxAdapter(
                child: MealDetailsTabBar(),
              ),
              SliverPadding(
                padding: EdgeInsetsDirectional.only(
                  start: 24.w,
                  top: 24.h,
                  bottom: 16.h,
                ),
                sliver: SliverFillViewport(
                  viewportFraction: 1.0,
                  delegate: SliverChildBuilderDelegate(
                    (_, __) => MealDetailsTabBarView(
                      meal: meal,
                    ),
                    childCount: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
