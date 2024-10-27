import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_recommendations/core/routing/routes.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import '../../../../../core/themes/app_colors.dart';
import '../controller/sign_up_bloc.dart';
import '../controller/user_events.dart';
import '../controller/user_states.dart';
import '../widgets/overlay.dart';



class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  var isPasssword = true;

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
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    Image.asset(Assets.AuthLogo, height: screenHeight * 0.09),
                    SizedBox(height: screenHeight * 0.05),
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
                      prefixPath: Assets.Account,
                    ),
                    SizedBox(height: screenHeight * 0.02), // Spacing

                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
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
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      prefixPath: Assets.Mobile, // SVG path for prefix
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Create Password Field
                    BlocBuilder<UserBloc,UserState>(
                      builder: (BuildContext context, UserState state) {
                        return defaultFormField(
                          controller: passwordController,
                          type: TextInputType.text,
                          isPassword: isPasssword,
                          suffixSvgPath: Assets.Eye,
                          suffixPressed: (){
                             isPasssword=!isPasssword;

                            BlocProvider.of<UserBloc>(context).add(
                              TogglePasswordEvent(isPasssword)
                            );

                          },

                          label: 'Create Password',
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          prefixPath: Assets.Lock, // SVG path for prefix
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Terms and Conditions Checkbox
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        bool isAccepted = false;
                        if (state is UserInitialState) {
                          isAccepted = state.termsAccepted;
                        }

                        return Row(
                          children: [
                            Checkbox(
                              value: isAccepted,
                              onChanged: (value) {
                                BlocProvider.of<UserBloc>(context).add(
                                  ToggleTermsEvent(value ?? false),
                                );
                              },
                              activeColor: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                'By creating an account you agree to terms and conditions',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    // Register Button
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadingState) {
                          return const CircularProgressIndicator(); // Show loading spinner during registration
                        }
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (validateInputs()) {
                                BlocProvider.of<UserBloc>(context).add(
                                  SignUpEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    fullName: nameController.text,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Scaled padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: screenWidth * 0.045), // Scaled text size
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is UserErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is UserSuccessState) {
                          Navigator.pushNamed(context, Routes.verifyOtp);
                        }
                      },
                      child: const SizedBox.shrink(), // No need to return a widget here
                    ),

                    Text(
                      'or login with',
                      style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.04), // Scaled font size
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Social Media Buttons
                    Center(
                      child: IconButton(
                        icon: SvgPicture.asset(Assets.svgsGoogleLogo, height: screenWidth * 0.1),
                        onPressed: () {},
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Already have an account
                    TextButton(
                      onPressed: () {
                        // Navigate to login screen
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        "Do have an account? Login now",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: screenWidth * 0.035, // Scaled text size
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateInputs() {
    if (nameController.text.isEmpty) {
      return false;
    }
    if (emailController.text.isEmpty) {
      return false;
    }
    if (passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }
}

