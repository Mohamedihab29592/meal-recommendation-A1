import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class ProfileTextFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final bool isEditing;

  const ProfileTextFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final double fontSize = screenSize.width > 600 ? 18 : 16;

    return Column(
      children: [
        const SizedBox(height: 22),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: nameController,
            readOnly: !isEditing,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(fontSize: fontSize),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: AppColors.textFormColor,
                  width: 2.0,
                ),
              ),
            ),
            style: AppTextStyles.font14Regular,
          ),
        ),
        const SizedBox(height: 22),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
              controller: emailController,
              readOnly: !isEditing,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: fontSize),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: AppColors.textFormColor,
                    width: 2.0,
                  ),
                ),
              ),
              style: AppTextStyles.font14Regular),
        ),
        const SizedBox(height: 22),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: phoneController,
            readOnly: !isEditing,
            decoration: InputDecoration(
              labelText: 'Phone',
              labelStyle: TextStyle(fontSize: fontSize),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: AppColors.textFormColor,
                  width: 2.0,
                ),
              ),
            ),
            style: AppTextStyles.font14Regular,
          ),
        ),
      ],
    );
  }
}
