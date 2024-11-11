import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

UserModel? currentUser;

class AppConstants {
  AppConstants._();

  static const List<String> mealDetailsTabs = [
    AppStrings.summary,
    AppStrings.ingredients,
    AppStrings.direction,
  ];
}
