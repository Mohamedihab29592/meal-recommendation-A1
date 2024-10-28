import 'package:flutter/material.dart';

import '../../../../../core/utils/assets.dart';

Widget watermarkOverlay() {
  return Positioned.fill(
    child: Opacity(
      opacity: 0.10, // Adjust the opacity as needed
      child: Image.asset(
        width: double.infinity,
        height: double.infinity,
        Assets.auth_background,
        fit: BoxFit.fill,
      ),
    ),
  );
}


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  VoidCallback? onTap,
  required String? Function(String?)? validate,
  required String label,
  required String prefixPath, // SVG path for the prefix
  bool isClickable = true,
  bool? isPassword,
  String? suffixSvgPath, // SVG path for the suffix (optional)
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      keyboardType: type,
      enabled: isClickable,
      obscureText: isPassword ?? false,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
        hintText: label,  // You can replace this if you want a different hint text
        hintStyle: const TextStyle(color: Colors.white70), // Hint text in white (with slight opacity)
        // Prefix Icon as SVG
        prefixIcon: Image.asset(prefixPath,height: 10,width: 10,),

        suffixIcon: suffixSvgPath != null
            ? InkWell(
          onTap: suffixPressed,
          child: Padding(
            padding:  const EdgeInsets.all(5.0), // Adjust as needed
            child:  Image.asset(suffixSvgPath,height: 10,width: 10,),
          ),
        )
            : null,
        // White Border Style
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white), // White border when not focused
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0), // White border when focused
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), // Red border on error
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0), // Red border on focused error
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );