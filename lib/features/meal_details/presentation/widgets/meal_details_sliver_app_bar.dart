import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:meal_recommendations/core/widgets/arrow_back_icon_button.dart';

class MealDetailsSliverAppBar extends StatelessWidget {
  const MealDetailsSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const ArrowBackIconButton(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(Assets.iconsHeartIcon),
        ),
      ],
    );
  }
}
