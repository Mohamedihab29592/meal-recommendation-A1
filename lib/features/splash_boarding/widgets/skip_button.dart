import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text('skip', style: AppTextStyles.textOnboarding),
    );
  }
}
