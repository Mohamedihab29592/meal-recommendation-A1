// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meal_recommendations/core/themes/app_text_styles.dart';
//
// import '../businessLogic/meal_cubit.dart';
// import 'filter_section.dart';
//
// class ShowFilterMealsBottomSheet extends StatefulWidget {
//   const ShowFilterMealsBottomSheet({super.key});
//
//   @override
//   _ShowFilterMealsBottomSheetState createState() =>
//       _ShowFilterMealsBottomSheetState();
// }
//
// class _ShowFilterMealsBottomSheetState
//     extends State<ShowFilterMealsBottomSheet> {
//   String? selectedMeal;
//   String? selectedTime;
//   num? selectedIngredientCount;
//
//   final meals = ['Breakfast', 'Lunch', 'Dinner', 'Drink', 'Dessert', 'Snacks'];
//   final times = ['5min', '10min', '15min+'];
//   final numOfIngredients = [3, 4, 5];
//
//   void resetFilters() {
//     setState(() {
//       selectedMeal = null;
//       selectedTime = null;
//       selectedIngredientCount = null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var listInBloc = context.read<MealCubit>().filterListBottomSheet(
//           mealType: selectedMeal,
//           mealTime: selectedTime,
//           numOfIngredients: selectedIngredientCount,
//         );
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 32),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 3 / 4,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             _buildHeader(),
//             const SizedBox(height: 16),
//             FilterSection(
//               title: "Meal",
//               options: meals,
//               selectedOption: selectedMeal,
//               onSelect: (value) => setState(() => selectedMeal = value),
//             ),
//             const SizedBox(height: 20),
//             FilterSection(
//               title: "Time",
//               options: times,
//               selectedOption: selectedTime,
//               onSelect: (value) => setState(() => selectedTime = value),
//             ),
//             const SizedBox(height: 20),
//             FilterSection<num>(
//               title: "Number of Ingredients",
//               options: numOfIngredients,
//               selectedOption: selectedIngredientCount,
//               onSelect: (value) =>
//                   setState(() => selectedIngredientCount = value),
//               displayAsString: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           "Filter",
//           style: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         TextButton(
//           onPressed: resetFilters,
//           child: Text(
//             "Reset",
//             style: AppTextStyles.font18Medium
//                 .copyWith(color: const Color(0xff023884)),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import '../businessLogic/meal_cubit.dart';
import 'filter_section.dart';

class ShowFilterMealsBottomSheet extends StatefulWidget {
  const ShowFilterMealsBottomSheet({super.key});

  @override
  _ShowFilterMealsBottomSheetState createState() =>
      _ShowFilterMealsBottomSheetState();
}

class _ShowFilterMealsBottomSheetState
    extends State<ShowFilterMealsBottomSheet> {
  String? selectedMeal;
  String? selectedTime;
  num? selectedIngredientCount;

  final meals = ['Breakfast', 'Lunch', 'Dinner', 'Drink', 'Dessert', 'Snacks'];
  final times = ['5min', '10min', '15min+'];
  final numOfIngredients = [3, 4, 5];

  void resetFilters() {
    setState(() {
      selectedMeal = null;
      selectedTime = null;
      selectedIngredientCount = null;
    });

    context.read<MealCubit>().filterListBottomSheet(
          mealType: null,
          mealTime: null,
          numOfIngredients: null,
        );
  }

  void applyFilters() {
    context.read<MealCubit>().filterListBottomSheet(
          mealType: selectedMeal,
          mealTime: selectedTime,
          numOfIngredients: selectedIngredientCount,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 3 / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 16),
            FilterSection(
              title: "Meal",
              options: meals,
              selectedOption: selectedMeal,
              onSelect: (value) {
                setState(() => selectedMeal = value);
                applyFilters();
              },
            ),
            const SizedBox(height: 20),
            FilterSection(
              title: "Time",
              options: times,
              selectedOption: selectedTime,
              onSelect: (value) {
                setState(() => selectedTime = value);
                applyFilters();
              },
            ),
            const SizedBox(height: 20),
            FilterSection<num>(
              title: "Number of Ingredients",
              options: numOfIngredients,
              selectedOption: selectedIngredientCount,
              onSelect: (value) {
                setState(() => selectedIngredientCount = value);
                applyFilters();
              },
              displayAsString: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Filter",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextButton(
          onPressed: resetFilters,
          child: Text(
            "Reset",
            style: AppTextStyles.font18Medium
                .copyWith(color: const Color(0xff023884)),
          ),
        ),
      ],
    );
  }
}
