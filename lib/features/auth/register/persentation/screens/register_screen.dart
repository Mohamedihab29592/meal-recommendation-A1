import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_recommendations/core/utils/assets.dart';

import '../../../../../core/themes/app_colors.dart';
import '../widgets/overlay.dart';


class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            watermarkOverlay(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06), // Padding based on screen width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1), // Scaled height
                  // Logo
                  Container(
                    child:Image.asset(Assets.AuthLogo,height: screenHeight*0.09,),
                  ),
                  SizedBox(height: screenHeight * 0.05), // Spacing after logo

                  // Full Name Field
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    label: 'Full Name',
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    prefixPath: Assets.Account, // SVG path for prefix
                  ),

                  SizedBox(height: screenHeight * 0.02), // Spacing

                  // Email Field
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email Addrees',
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    prefixPath: Assets.Mail, // SVG path for prefix
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Mobile Number Field
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone Number',
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    prefixPath: Assets.Mobile, // SVG path for prefix
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Create Password Field
                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.text,
                    label: 'Create Password',
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    prefixPath: Assets.Lock, // SVG path for prefix
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Confirm Password Field
                  defaultFormField(
                    controller: passwordController,
                    type: TextInputType.text,
                    label: 'Full Name',
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    prefixPath: Assets.Lock, // SVG path for prefix
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                        activeColor: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          'by creating an account you agree to terms and conditions',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: screenWidth * 0.035, // Scaled font size
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Scaled padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: Text(
                        'register',
                        style: TextStyle(fontSize: screenWidth * 0.045), // Scaled text size
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Divider or login with
                  Text(
                    'or login with',
                    style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.04), // Scaled font size
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Social Media Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(Assets.svgFacebookLogo,height: screenWidth * 0.1),
                        onPressed: () {},
                      ),
                      SizedBox(width: screenWidth * 0.06), // Scaled spacing
                      IconButton(
                        icon: SvgPicture.asset(Assets.svgsGoogleLogo, height: screenWidth * 0.1),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  // Already have an account
                  SizedBox(height: screenHeight * 0.02),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "don't have an account? register now",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: screenWidth * 0.035, // Scaled text size
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




}

