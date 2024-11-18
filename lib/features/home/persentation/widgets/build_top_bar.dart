import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/themes/app_colors.dart';

class BuildTopBar extends StatelessWidget {
  const BuildTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            //todo openDrawer
          },
          icon: Icon(
            Icons.menu,
            color: AppColors.primaryColor,
            size: MediaQuery.of(context).size.width * 0.073,
          ),
        ),
        IconButton(
          onPressed: () {
            //todo  Navigator.pushNamed(context, '/suggestedMeal');
          },
          icon: Icon(
            FontAwesomeIcons.robot,
            color: AppColors.primaryColor,
            size: MediaQuery.of(context).size.width * 0.073,
          ),
        ),
      ],
    );
  }
}
