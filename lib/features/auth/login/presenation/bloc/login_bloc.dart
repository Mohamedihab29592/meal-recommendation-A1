import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/models/auth_action_params.dart';
import 'package:meal_recommendations/features/auth/login/data/repository/login_repo.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_event.dart';
import 'package:meal_recommendations/features/auth/login/presenation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo _loginRepo;

  LoginBloc(this._loginRepo) : super(LoginState.initial()) {
    on<Login>(_login);
    on<GoogleLogin>(_googleLogin);
    on<TogglePasswordVisibility>(_togglePassVisibility);
    on<AlwaysAutovalidateMode>(_alwaysAutovalidateMode);
    _initFormAttributes();
  }

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  void _initFormAttributes() {
    _initControllers();
    formKey = GlobalKey<FormState>();
  }

  void _initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _login(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStateStatus.loginLoading));
    final AuthActionParams params = AuthActionParams(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    final result = await _loginRepo.login(params);
    result.fold(
      (errorModel) => emit(state.copyWith(
        status: LoginStateStatus.loginError,
        error: errorModel.error,
      )),
      (user) => emit(state.copyWith(
        status: LoginStateStatus.loginSuccess,
        user: user,
      )),
    );
  }

  void validateAndLogin() {
    if (formKey.currentState!.validate()) {
      add(Login());
    } else {
      add(AlwaysAutovalidateMode());
    }
  }

  void _googleLogin(
    GoogleLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      status: LoginStateStatus.googleLoginLoading,
    ));
    final result = await _loginRepo.googleLogin();
    result.fold(
      (errorModel) => emit(state.copyWith(
        status: LoginStateStatus.googleLoginError,
        error: errorModel.error,
      )),
      (credentials) => emit(state.copyWith(
        status: LoginStateStatus.googleLoginSuccess,
        credential: credentials,
      )),
    );
  }

  void _togglePassVisibility(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      status: LoginStateStatus.togglePassVisibility,
      isPassObscured: !state.isPassObscured,
    ));
  }

  void _alwaysAutovalidateMode(
    AlwaysAutovalidateMode event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      status: LoginStateStatus.alwaysAutovalidateMode,
      autovalidateMode: AutovalidateMode.always,
    ));
  }

  void _cacheUserId(String userId) {}

  void _disposeController() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Future<void> close() {
    _disposeController();
    return super.close();
  }
}
