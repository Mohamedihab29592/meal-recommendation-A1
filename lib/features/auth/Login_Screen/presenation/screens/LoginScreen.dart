import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/utils/assets.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/state/login_events.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/widgets/CustomFormField.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/widgets/CustomButton.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/widgets/CustomCheckBox.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/widgets/NoAccountText.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/widgets/OrLoginWith.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/widgets/SocalCard.dart';
import '../../../../../core/routing/routes.dart';
import '../controller/Login_bloc/bloc/Login BLoc.dart';
import '../controller/Login_bloc/state/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final box = Hive.box('appBox');


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
            // Set the login status 
           box.put('isLoggedIn', true); 
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Login Successful',
              style: TextStyle(
                fontSize: MediaQuery.sizeOf(context).width * 0.04,
              ),
            ),
          ));
          Navigator.pushReplacementNamed(context, Routes.layout);
        } else if (state is LoginErrorState) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              state.error,
              style: TextStyle(
                fontSize: MediaQuery.sizeOf(context).width * 0.04,
              ),
            ),
          ));
        }
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<LoginBloc>(context);
        return Stack(
          children: [
            Container(
              color: AppColors.primaryColor,
              child: Image.asset(
                'assets/images/background.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                        ),
                        Center(
                          child: Image.asset(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.sizeOf(context).height * 0.16,
                            'assets/images/logo.png',
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Form(
                          key: bloc.formKey, // Use BLoC's formKey
                          child: Column(
                            children: [
                              CustomTextFormField(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: 'User Name',
                                controller: bloc
                                    .emailController, // Use BLoC's controller
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return 'Please Enter Email Address';
                                  }
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(text);
                                  if (!emailValid) {
                                    return 'Please Enter Valid Email';
                                  }
                                  return null;
                                },
                              ),
                              CustomTextFormField(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Password',
                                suffixIcon: InkWell(
                                  child: bloc.isObsecure
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                        ),
                                  onTap: () {
                                    setState(() {
                                      bloc.isObsecure = !bloc.isObsecure;
                                    });
                                  },
                                ),
                                isObsecure: bloc
                                    .isObsecure, // Toggle password visibility
                                controller: bloc
                                    .passwordController, // Use BLoC's controller
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              const CustomCheckbox(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              CustomButton(
                                title: 'Login',
                                onPressed: () {
                                  bloc.add(
                                    signInWithEmailAndPasswordEvent(
                                      bloc.emailController.text,
                                      bloc.passwordController.text,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        const OrLOginWith(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        SocialCard(
                          icon: SvgPicture.string(Assets.googleIcon),
                          press: () {
                            // Dispatch Google login event
                            bloc.add(signInGoogleEvent());
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        const NoAccountText()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

