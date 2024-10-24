import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Update the import to reflect correct path

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isObsecure;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.isObsecure = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: FocusNode(),
        controller: controller,
        validator: validator,
        obscureText: isObsecure,
        style: const TextStyle(color: Colors.white), // Text color
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54), // Hint text color
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
            vertical: MediaQuery.of(context).size.height * 0.025,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rectangular corners
            borderSide: const BorderSide(
              color: Colors.white70, // Default border color
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rectangular corners
            borderSide: const BorderSide(
              color: Colors.white, // Enabled border color
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Rectangular corners
            borderSide: const BorderSide(
              color: Colors.white, // Focused border color
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

