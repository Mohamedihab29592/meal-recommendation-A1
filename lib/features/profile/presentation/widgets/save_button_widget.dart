import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class SaveButtonWidget extends StatelessWidget {
  final bool isEditing;
  final Function() onSavePressed;

  const SaveButtonWidget({
    super.key,
    required this.isEditing,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final double buttonWidth = screenSize.width * 0.8;
    const double buttonHeight = 68;

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.primaryColor,
      ),
      child: ElevatedButton(
        onPressed: isEditing ? onSavePressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
        ),
        child: Text(
          'Save',
          style: AppTextStyles.textElevatedButton,
        ),
      ),
    );
  }
}
