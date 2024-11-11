import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 2,
            horizontal:
                MediaQuery.of(context).size.width*0.3), // Padding for height

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(
          vertical:  MediaQuery.of(context).size.height*0.015,
              horizontal: MediaQuery.of(context).size.width*0.05
        ),
        child: Text(
          title!,
          style:  TextStyle(
              color: AppColors.primaryColor,
              fontSize: MediaQuery.sizeOf(context).width*0.05,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
