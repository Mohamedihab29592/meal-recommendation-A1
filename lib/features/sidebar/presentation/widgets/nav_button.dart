import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class NavButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double iconSize;
  final double fontSize;

  const NavButton({super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.iconSize = 24.0,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: iconSize, color: isSelected ? AppColors.primaryColor : Colors.grey),
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: isSelected ? AppColors.primaryColor : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}
