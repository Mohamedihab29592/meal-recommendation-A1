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
        size: MediaQuery.of(context).size.width * 0.065,
      ),
      onChanged: (value) {
        context.read<MealCubit>().searchedMealsList(value);
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
            _showModalBottomSheet(context);
          },
          icon: Icon(
            FontAwesomeIcons.sliders,
            size: MediaQuery.of(context).size.width * 0.05,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return
            // BlocProvider.value(
            // value: context.read<MealCubit>(), // Pass the existing MealCubit
            // child: const
            const ShowFilterMealsBottomSheet();
      },
    );
  }
}
