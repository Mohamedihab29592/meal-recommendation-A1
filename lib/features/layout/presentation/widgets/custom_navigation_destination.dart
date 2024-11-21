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
      icon: SizedBox(
        width: 24.w,
        height: 24.h,
        child: Image.asset(icon),
      ),
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
        padding: EdgeInsets.all(16.h), // Equal padding for uniform scaling
        margin: EdgeInsets.only(bottom: 8.h),
        child: SizedBox(
          width: 28.w,
          height: 28.h,
          child: Image.asset(selectedIcon),
        ),
      ),
    );
  }
}
