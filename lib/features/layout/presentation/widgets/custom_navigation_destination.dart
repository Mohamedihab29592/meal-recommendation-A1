import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class CustomNavigationDestination extends StatelessWidget {
  const CustomNavigationDestination({
    super.key,
    required this.icon,
    required this.selectedIcon,
  });

  final String icon, selectedIcon;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Image.asset(icon),
      label: '',
      selectedIcon: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4.h),
              blurRadius: 4.r,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
        margin: EdgeInsets.only(bottom: 8.h),
        child: Image.asset(selectedIcon),
      ),
    );
  }
}
