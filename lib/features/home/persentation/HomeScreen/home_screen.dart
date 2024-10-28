import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/helpers/bloc_observer.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/features/home/persentation/HomeScreen/recipe_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_recommendations/features/home/persentation/businessLogic/meal_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundLightColor,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        color: AppColors.primaryColor,
                        size: 30.r,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: AppColors.primaryColor,
                            size: 30.r,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  SearchBar(
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.0.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    elevation: const WidgetStatePropertyAll(1),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        side: const BorderSide(color: Color(0xffDEDEDE)),
                        borderRadius: BorderRadius.circular(12.r))),
                    leading: Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                      size: 24.r,
                    ),
                    onChanged: (value) {
                      context.read<MealCubit>().filterMealsList(value);
                    },
                    hintText: 'Search recipes',
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: [
                      Icon(
                        FontAwesomeIcons.sliders,
                        size: 16.r,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 5.w,
                      )
                    ],
                  ),
                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 160.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: AppColors.primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              'add your ingredients',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Recipes',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 20.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const RecipeCard()),
                ],
              )),
        ),
      ),
    );
  }
}
