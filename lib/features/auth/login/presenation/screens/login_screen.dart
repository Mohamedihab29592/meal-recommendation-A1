import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:meal_recommendations/core/widgets/my_sized_box.dart';
import 'package:meal_recommendations/features/auth/login/presenation/widgets/CustomCheckBox.dart';
import 'package:meal_recommendations/features/auth/login/presenation/widgets/NoAccountText.dart';
import 'package:meal_recommendations/features/auth/login/presenation/widgets/OrLoginWith.dart';
import 'package:meal_recommendations/features/auth/login/presenation/widgets/google_login_bloc_listener.dart';
import 'package:meal_recommendations/features/auth/login/presenation/widgets/login_bloc_listener.dart';
import 'package:meal_recommendations/features/auth/login/presenation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.primaryColor,
          child: Image.asset(
            Assets.imagesBackground,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MySizedBox.height34,
                    Center(
                      child: Image.asset(Assets.imagesLogo),
                    ),
                    MySizedBox.height69,
                    const LoginFormBlocSelector(),
                    const CustomCheckbox(),
                    MySizedBox.height48,
                    const LoginBlocListener(),
                    const OrLoginWith(),
                    MySizedBox.height48,
                    const GoogleLoginBlocListener(),
                    MySizedBox.height34,
                    const NoAccountText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
