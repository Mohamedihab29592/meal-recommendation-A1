import 'package:flutter/material.dart';

import '../../../../../core/themes/app_colors.dart';
class BuildTopBar extends StatelessWidget {
  const BuildTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: AppColors.primaryColor,
            size: MediaQuery.of(context).size.width * 0.08,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: AppColors.primaryColor,
            size: MediaQuery.of(context).size.width * 0.08,
          ),
        ),
      ],
    );
  }
}
