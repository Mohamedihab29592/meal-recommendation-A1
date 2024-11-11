import 'package:meal_recommendations/core/helpers/regex_validator.dart';
import 'package:meal_recommendations/core/utils/strings.dart';

class TextFormValidator {
  TextFormValidator._();

  static String? validateEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    } else if (!RegexValidator.isEmailValid(value)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    } else if (value.length < 8) {
      return AppStrings.passwordInvalidLength;
    }
    return null;
  }
}
