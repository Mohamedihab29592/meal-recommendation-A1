// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:hive/hive.dart';

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
            onPressed: () async {
              final box = Hive.box('appBox');
              await box.put('onboardingShown', true); 
              print('Onboarding status saved: true');
              bool onboardingCheck = box.get('onboardingShown');
              print('Onboarding status after saving: $onboardingCheck'); 
              Navigator.of(context).pushReplacementNamed(Routes.login);
            },
            child: Text('Login', style: AppTextStyles.textOnboarding),
          ),
        if (currentPage != totalPages - 1)
          TextButton(
            onPressed: onNext,
            child: Text('Next', style: AppTextStyles.textOnboarding),
          ),
      ],
    );
  }
}
