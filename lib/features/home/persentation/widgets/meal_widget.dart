// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/features/home/businessLogic/bloc/meal_bloc.dart';
import 'package:meal_recommendations/features/home/businessLogic/bloc/meal_event_bloc.dart';
import 'package:meal_recommendations/features/home/businessLogic/bloc/meal_state_bloc.dart';


class MealWidget extends StatefulWidget {
  const MealWidget({super.key});

  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  String? userId;
  List<Meal> meals = [];

  @override
  void initState() {
    super.initState();
    _loadUid();
  }

  Future<void> _loadUid() async {
    await SecureStorageHelper.getSecuredString(CacheKeys.cachedUserId)
        .then((value) {
      _loadData(value);
    });
  }

  void _loadData(String? uid) {
    if (uid != null && mounted) {
      setState(() {
        userId = uid;
      });

      context.read<MealBloc>().add(FetchMeals(userId!));
    } else {
      debugPrint('No user ID found in secure storage.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return BlocBuilder<MealBloc, MealState>(
      builder: (context, state) {
        if (state is MealLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MealLoaded) {
          meals = state.meals;

          if (meals.isEmpty) {
            return Center(
              child: Text(
                'No meals available.',
                style: AppTextStyles.font15MediumBlueGrey,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return Column(
                      children: [
                        Container(
                          height: mediaQuery.size.height * 0.17,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.grey0, width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.01),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.1,
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.02),
                                    child: CircleAvatar(
                                      radius: mediaQuery.size.width * 0.13,
                                      child: Image.network(
                                        meal.imageUrl ??
                                            'https://cdn-icons-png.flaticon.com/512/4131/4131735.png',
                                        height: screenHeight * 0.08,
                                        width: screenWidth * 0.15,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.size.height * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        meal.mealType ?? 'No type ',
                                        style:
                                            AppTextStyles.font15MediumBlueGrey,
                                      ),
                                      Text(
                                        meal.name ?? 'No name ',
                                        style: AppTextStyles.textElevatedButton
                                            .copyWith(color: Colors.black),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            meal.ingredients != null &&
                                                    meal.ingredients!.isNotEmpty
                                                ? "${meal.ingredients!.length} ingredients"
                                                : 'No ingredients ',
                                            style:
                                                AppTextStyles.font15MediumGrey,
                                          ),
                                          SizedBox(width: screenWidth * 0.03),
                                          Text(
                                            "${meal.cookTime} min",
                                            style: AppTextStyles
                                                .font15MediumBlueGrey,
                                          ),
                                        ],
                                      ),
                                      const Spacer(
                                        flex: 2,
                                      ),
                                      Row(
                                        children: List.generate(5, (index) {
                                          if (meal.rating == null) {
                                            return const Icon(
                                                Icons.star_border_outlined,
                                                color: Colors.grey,
                                                size: 18);
                                          } else if (index + 1 <=
                                              meal.rating!.toInt()) {
                                            return const Icon(Icons.star,
                                                color: Colors.amber, size: 18);
                                          } else if (index + 0.5 <
                                              meal.rating!) {
                                            return const Icon(Icons.star_half,
                                                color: Colors.amber, size: 18);
                                          } else {
                                            return const Icon(Icons.star_border,
                                                color: Colors.amber, size: 18);
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                // SizedBox(width: screenWidth * 0.1),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.09),
                                  child: IconButton(
                                    onPressed: () {
                                      final mealBloc =
                                          BlocProvider.of<MealBloc>(context);

                                      if (meal.isFavourite) {
                                        mealBloc.removeFavMeal(meal).then(
                                              (_) => _showSnackBar(context,
                                                  'Meal removed successfully'),
                                            );
                                      } else {
                                        mealBloc
                                            .updateIsFavInFireStore(
                                                meal.dishName ?? '',
                                                meal.isFavourite)
                                            .then(
                                              (_) => _showSnackBar(context,
                                                  'Meal added to favorites'),
                                            );
                                      }
                                    },
                                    icon: Icon(
                                      meal.isFavourite
                                          ? Icons.favorite
                                          : Icons.favorite_outline_outlined,
                                      color: meal.isFavourite
                                          ? AppColors.primaryColor
                                          : AppColors.grey,
                                      size: mediaQuery.size.width * 0.07,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is MealError) {
          return const Center(
              child: Text(
            'Failed to fetch meals: ',
          ));
        }
        return const Center(
            child: Text(
          'No meals found.',
        ));
      },
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
