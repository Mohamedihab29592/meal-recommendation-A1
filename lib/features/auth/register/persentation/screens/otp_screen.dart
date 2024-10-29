import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';
import 'package:meal_recommendations/features/auth/register/persentation/cubit/otp_auth_cubit.dart';
import '../../../../../core/themes/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = "";
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return ScaffoldMessenger(
      child: BlocListener<OtpAuthCubit, OtpAuthState>(
        listener: (context, state) {
          if (state is OtpAuthLoading) {
            _showMyDialog(context);
          } else if (state is OtpAuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is OtpAuthFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP verification failed')),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              _buildBackground(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.1),
                    _buildHeader(width, height),
                    SizedBox(height: height * 0.05),
                    _buildOtpField(width),
                    SizedBox(height: height * 0.05),
                    _buildContinueButton(width, height),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onOtpChange(String value) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        otpCode = value;
        isButtonEnabled = otpCode.length == 4;
      });
    });
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/auth_background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          decoration:
              BoxDecoration(color: AppColors.primaryColor.withOpacity(0.85)),
        ),
      ],
    );
  }

  Widget _buildHeader(double width, double height) {
    return Column(
      children: [
        SizedBox(height: height * 0.05),
        Image.asset(
          'assets/images/logo.png',
          width: width * 0.3,
          height: width * 0.3,
        ),
        SizedBox(height: height * 0.02),
        Text('verification',
            style: AppTextStyles.font21BoldDarkBlue
                .copyWith(color: Colors.white, fontSize: 28)),
        SizedBox(height: height * 0.01),
        Text(
          'Enter 4 digits verification code. We just sent you on ${context.read<OtpAuthCubit>().phoneNumber}',
          textAlign: TextAlign.center,
          style: AppTextStyles.font18RegularDarkBlue.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField(double width) {
    return OtpTextField(
      onSubmit: (value) => _onOtpChange(value),
      onCodeChanged: (_) => setState(() => isButtonEnabled = false),
      focusedBorderColor: Colors.white,
      showFieldAsBox: true,
      fillColor: Colors.white,
      fieldWidth: width * 0.15,
      textStyle: AppTextStyles.font21BoldDarkBlue,
      filled: true,
    );
  }

  Widget _buildContinueButton(double width, double height) {
    return GestureDetector(
      onTap: isButtonEnabled
          ? () {
              context.read<OtpAuthCubit>().otpCode = otpCode;
              context.read<OtpAuthCubit>().verifyOtp();
            }
          : null,
      child: Container(
        width: width * 0.85,
        height: height * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Center(
          child: Text('continue', style: AppTextStyles.font21BoldDarkBlue),
        ),
      ),
    );
  }
}

void _showMyDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 80,
            child: Transform.scale(
              scale: 0.7,
              child: const LoadingIndicator(
                indicatorType: Indicator.ballRotateChase,
                colors: [AppColors.primaryColor],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'please wait...',
            style: AppTextStyles.font18RegularDarkBlue,
          ),
        ]),
      );
    },
  );
}
