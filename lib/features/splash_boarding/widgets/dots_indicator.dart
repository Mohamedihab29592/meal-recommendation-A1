import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class DotsIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const DotsIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
          height: screenWidth * 0.025, 
          width: screenWidth * 0.085, 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.013), 
            color: currentPage == index
                ? AppColors.primaryColor
                : AppColors.inActiveDots,
          ),
        ),
      ),
    );
  }
}
