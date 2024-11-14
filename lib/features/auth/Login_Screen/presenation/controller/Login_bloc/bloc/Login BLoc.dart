import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/state/login_events.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/state/login_state.dart';
import '../../../../domain/repositories/BaseLoginRepository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  final BaseLoginRepository loginRepository;

  bool isObsecure = true;

  LoginBloc(this.loginRepository) : super(LoginInitialState()) {
    on<signInWithEmailAndPasswordEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var login = await loginRepository.signInWithEmailAndPassword(
            event.email, event.password);

        await login?.fold((l) {
          emit(LoginErrorState(l.error));
        }, (response) async {
          _setSecuredUserId(response.user!.uid);
          emit(LoginSuccessState(response));
        });
      } catch (e) {
        log(e.toString());
        emit(LoginErrorState('An unexpected error occurred: ${e.toString()}'));
      }
    });

    on<signInGoogleEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var login = await loginRepository.signInWithGoogle();

        await login?.fold((l) {
          emit(LoginErrorState(l.error));
        }, (response) async {
          _setSecuredUserId(response.user!.uid);
          emit(LoginSuccessState(response));
        });
      } catch (e) {
        emit(LoginErrorState(
            'An error occurred during Google sign in: ${e.toString()}'));
      }
    });
  }

  void _setSecuredUserId(String userId) {
    SecureStorageHelper.setSecuredString(
      CacheKeys.cachedUserId,
      userId,
    );
  }
}
