import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/helpers/extensions.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class ArrowBackIconButton extends StatelessWidget {
  const ArrowBackIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.pop(),
      icon: const Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.primaryColor,
      ),
    );
  }
}
