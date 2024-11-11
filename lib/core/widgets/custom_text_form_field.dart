import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validate,
    this.onChanged,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.onSubmit,
    this.autofillHints,
    this.focusNode,
    this.onEditingComplete,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.enabledBorder,
    this.focusedBorder,
    this.enabled,
    this.margin,
    this.border,
    this.errorBorder,
    this.focusedErrorBorder,
    this.hintStyle,
    this.disabledBorder,
    this.autofocus = false,
    this.onSaved,
    this.maxLength,
  });

  final TextInputType keyboardType;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final void Function(String)? onChanged;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String submittedText)? onSubmit;
  final List<String>? autofillHints;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final bool? enabled;
  final EdgeInsetsGeometry? margin;
  final bool autofocus;
  final Function(String? value)? onSaved;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      enabled: enabled,
      selectionHeightStyle: BoxHeightStyle.strut,
      obscureText: obscureText ?? false,
      autofillHints: autofillHints,
      validator: validate,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      maxLength: maxLength,
      focusNode: focusNode,
      keyboardType: keyboardType,
      cursorColor: AppColors.primaryColor,
      cursorErrorColor: AppColors.primaryColor,
      textCapitalization: textCapitalization,
      textAlign: textAlign,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIconColor: AppColors.primaryColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? const EdgeInsets.all(13),
        disabledBorder: disabledBorder ?? _inputBorder,
        enabledBorder: enabledBorder ?? _inputBorder,
        focusedBorder: focusedBorder ?? _inputBorder,
        focusedErrorBorder: focusedErrorBorder ?? _inputBorder,
        errorBorder: errorBorder ?? _inputBorder,
        hintText: hintText ?? '',
        hintStyle: hintStyle ?? const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: AppColors.primaryColor,
        border: border ?? _inputBorder,
      ),
    );
  }

  InputBorder get _inputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // Rectangular corners
        borderSide: const BorderSide(
          color: Colors.white70, // Default border color
          width: 1,
        ),
      );
}
