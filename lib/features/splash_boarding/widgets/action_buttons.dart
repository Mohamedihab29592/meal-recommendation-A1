import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class ActionButtons extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;

  const ActionButtons({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentPage == totalPages - 1)
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.login);
            },
            child: Text('login', style: AppTextStyles.textOnboarding),
          ),
        if (currentPage != totalPages - 1)
          TextButton(
            onPressed: onNext,
            child: Text('next', style: AppTextStyles.textOnboarding),
          ),
      ],
    );
  }
}
