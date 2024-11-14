import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/models/meal.dart';
import 'package:meal_recommendations/features/home/persentation/HomeScreen/widgets/build_meal_details.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';
import '../../../../meal_details/presentation/views/meal_details_view.dart';
import '../../../businessLogic/meal_cubit.dart';

class BuildMealCard extends StatelessWidget {
  const BuildMealCard({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealDetailsView(meal: meal),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Color(0xffDEDEDE), offset: Offset(0, 2)),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(mediaQuery.size.width * 0.015),
          border: Border.all(color: const Color(0xffDEDEDE)),
        ),
        height: mediaQuery.size.height * 0.15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMealImage(meal.imageUrl, mediaQuery),
            BuildMealDetails(meal: meal),
            _buildFavoriteButton(context, meal, mediaQuery),
          ],
        ),
      ),
    );
  }

  Widget _buildMealImage(String? imageUrl, MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
      child: CircleAvatar(
        radius: mediaQuery.size.width * 0.13,
        backgroundImage: CachedNetworkImageProvider(imageUrl!),
      ),
    );
  }

  Widget _buildFavoriteButton(
      BuildContext context, Meal meal, MediaQueryData mediaQuery) {
    return IconButton(
      onPressed: () {
        meal.isFavourite
            ? BlocProvider.of<MealCubit>(context).removeFavMeal(meal).then(
                  (_) => _showSnackBar(context, 'Meal removed successfully'),
                )
            : BlocProvider.of<MealCubit>(context).addFavMeal(meal).then(
                  (_) => _showSnackBar(context, 'Meal added successfully'),
                );
      },
      icon: Icon(
        meal.isFavourite ? Icons.favorite : Icons.favorite_outline_outlined,
        color: AppColors.primaryColor,
        size: mediaQuery.size.width * 0.07,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryColor,
        content: Text(
          message,
          style: AppTextStyles.font16Regular.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
