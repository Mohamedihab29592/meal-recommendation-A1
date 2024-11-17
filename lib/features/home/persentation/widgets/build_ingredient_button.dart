import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';

class BuildIngredientButton extends StatelessWidget {
  const BuildIngredientButton({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          //todo  Navigator.pushNamed(context, '/suggestedMeal');
        },
        child: Container(
          width: mediaQuery.size.width * 0.45,
          height: mediaQuery.size.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mediaQuery.size.width * 0.07),
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: Text(
              'add your ingredients',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.white,
                fontSize: mediaQuery.size.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
