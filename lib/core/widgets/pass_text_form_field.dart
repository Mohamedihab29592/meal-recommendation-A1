import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/helpers/text_form_validator.dart';
import 'package:meal_recommendations/core/utils/strings.dart';
import 'package:meal_recommendations/core/widgets/custom_text_form_field.dart';

class PassTextFormField extends StatelessWidget {
  const PassTextFormField({
    super.key,
    required this.obscureText,
    this.controller,
    this.focusNode,
    this.passVisibilityOnTap,
    this.keyboardType = TextInputType.visiblePassword,
    this.autofillHints = const [AutofillHints.password],
    this.validate,
    this.hintText,
  });

  final bool obscureText;
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;
  final VoidCallback? passVisibilityOnTap;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      hintText: hintText ?? AppStrings.password,
      autofillHints: autofillHints,
      obscureText: obscureText,
      prefixIcon: const Icon(Icons.lock, color: Colors.white),
      suffixIcon: IconButton(
        onPressed: passVisibilityOnTap,
        icon: Icon(
          obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: Colors.white,
        ),
      ),
      validate: validate ??
          (String? value) => TextFormValidator.validatePasswordField(value),
    );
  }
}
