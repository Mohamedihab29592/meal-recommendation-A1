import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

enum LoginStateStatus {
  initial,
  loginLoading,
  loginSuccess,
  loginError,
  googleLoginLoading,
  googleLoginSuccess,
  googleLoginError,
  togglePassVisibility,
  alwaysAutovalidateMode,
}

@immutable
class LoginState {
  final LoginStateStatus status;
  final UserModel? user;
  final String? error;
  final bool isPassObscured;
  final AutovalidateMode autovalidateMode;
  final UserCredential? credential;

  const LoginState({
    required this.status,
    this.user,
    this.error,
    this.isPassObscured = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.credential,
  });

  LoginState copyWith({
    required LoginStateStatus status,
    UserModel? user,
    String? error,
    bool? isPassObscured,
    AutovalidateMode? autovalidateMode,
    UserCredential? credential,
  }) =>
      LoginState(
        status: status,
        user: user ?? this.user,
        error: error ?? this.error,
        isPassObscured: isPassObscured ?? this.isPassObscured,
        autovalidateMode: autovalidateMode ?? this.autovalidateMode,
        credential: credential ?? this.credential,
      );

  factory LoginState.initial() => const LoginState(
        status: LoginStateStatus.initial,
      );
}
