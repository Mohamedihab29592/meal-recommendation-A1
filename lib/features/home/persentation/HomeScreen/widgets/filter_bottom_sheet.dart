import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class ShowFilterMealsBottomSheet extends StatefulWidget {
  const ShowFilterMealsBottomSheet({super.key});

  @override
  _ShowFilterMealsBottomSheetState createState() => _ShowFilterMealsBottomSheetState();
}

class _ShowFilterMealsBottomSheetState extends State<ShowFilterMealsBottomSheet> {
  String? selectedMeal;
  String? selectedTime;
  String? selectedDifficulty;
  int ingredientCount = 5;

  final meals = ['Breakfast', 'Lunch', 'Dinner', 'Drink', 'Dessert', 'Snacks'];
  final times = ['5min', '10min', '15min+'];
  final difficulties = ['Beginner', 'Medium', 'Chef'];

  void selectMeal(String meal) {
    setState(() {
      selectedMeal = meal;
    });
  }

  void selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  void selectDifficulty(String difficulty) {
    setState(() {
      selectedDifficulty = difficulty;
    });
  }

  void resetFilters() {
    setState(() {
      selectedMeal = null;
      selectedTime = null;
      selectedDifficulty = null;
      ingredientCount = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 3 / 4,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filter",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                TextButton(
                    onPressed: resetFilters,
                    child: Text(
                      "Reset",
                      style: AppTextStyles.font18Medium
                          .copyWith(color: AppColors.primaryColor),
                    )),
              ],
            ),
            _buildFilterSection("Meal", meals, selectedMeal, selectMeal),
            _buildFilterSection("Time", times, selectedTime, selectTime),
            _buildFilterSection("Difficulty", difficulties, selectedDifficulty,
                selectDifficulty),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Number of ingredients"),
                Text("$ingredientCount"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options,
      String? selectedOption, Function(String) onSelect) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.font20Bold),
        Row(
          spacing: 16.0,
          children: options.map((option) {
            final isSelected = selectedOption == option;
            return ChoiceChip(
              showCheckmark: false,
              chipAnimationStyle: ChipAnimationStyle(
                  //   selectAnimation: AnimationStyle(duration: Duration(milliseconds: 0),)
                  ),
              selectedColor: AppColors.primaryColor,
              labelStyle: !isSelected
                  ? AppTextStyles.font18BoldDarkBlue
                      .copyWith(color: AppColors.grey)
                  : AppTextStyles.font18BoldDarkBlue
                      .copyWith(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              label: Text(option),
              selected: isSelected,
              onSelected: (_) => onSelect(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}
