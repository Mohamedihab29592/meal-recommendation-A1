import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import '../../../../core/themes/app_colors.dart';
import '../businessLogic/meal_cubit.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        if (state is MealLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else if (state is MealError) {
          return Center(child: Text(state.error));
        } else if (state is MealLoaded) {
          if (state.meals.isEmpty) {
            return const Center(child: Text('No meals available'));
          } else {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: state.meals.length,
              itemBuilder: (context, index) {
                final meal = state.meals[index];
                return Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffDEDEDE), // Shadow color with opacity
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: const Color(0xffDEDEDE),
                      )),
                  height: 115.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundImage:
                              const AssetImage('assets/images/pizza_image.png'),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SizedBox(
                        width: 120.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            Text(
                              meal.mealType!,
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                  fontSize: 15.sp),
                            ),
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              meal.name!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${meal.ingredients!.length} ingredients",
                                  style: TextStyle(
                                      color: AppColors.grey,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${meal.cookTime!.toString()}min",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                if (index + 1 <= meal.rating!.toInt()) {
                                  return const Icon(Icons.star,
                                      color: Colors.amber, size: 18);
                                } else if (index + 0.5 < meal.rating!.toInt()) {
                                  return const Icon(Icons.star_half,
                                      color: Colors.amber, size: 18);
                                } else {
                                  return const Icon(Icons.star_border,
                                      color: Colors.amber, size: 18);
                                }
                              }),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<MealCubit>(context)
                                .addFavMeal(meal)
                                .then(
                                  (value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          content: Text(
                                            'Meal added successfully',
                                            style: AppTextStyles.font16Regular
                                                .copyWith(color: Colors.white),
                                          ))),
                                );

                          },
                          icon: Icon(
                            meal.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                            color: AppColors.primaryColor,
                            size: 26.r,
                          )),
                    ],
                  ),
                );
              },
            );
          }
        }
        // Default state (initial)
        return const Center(child: Text('Please wait...'));
      },
    );
  }
}
