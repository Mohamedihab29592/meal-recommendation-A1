import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';
import '../businessLogic/meal_cubit.dart';
import 'filter_bottom_sheet.dart';

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      textStyle: WidgetStatePropertyAll(AppTextStyles.font16Regular),
      elevation: const WidgetStatePropertyAll(1),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xffDEDEDE)),
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
      )),
      leading: Icon(
        Icons.search,
        color: AppColors.primaryColor,
        size: MediaQuery.of(context).size.width * 0.06,
      ),
      onChanged: (value) {
        context.read<MealCubit>().filterMealsList(value);
      },
      hintText: 'Search Recipes',
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          color: AppColors.primaryColor,
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: [
        IconButton(
          onPressed: () {
            // TODO: Show filter bottom sheet will be completed in next week
            const ShowFilterMealsBottomSheet();
          },
          icon: Icon(
            FontAwesomeIcons.sliders,
            size: MediaQuery.of(context).size.width * 0.04,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
    ;
  }
}
