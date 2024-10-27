import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/state/login_events.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/presenation/controller/Login_bloc/state/login_state.dart';
import '../../../../domain/repositories/BaseLoginRepository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  final storage = const FlutterSecureStorage();

  final BaseLoginRepository loginRepository =
  GetIt.instance<BaseLoginRepository>();
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');
  bool isObsecure = true;

  LoginBloc() : super(LoginInitialState()) {
    on<signInWithEmailAndPasswordEvent>((event, emit) async {
      if (formKey.currentState?.validate() == true) {
        emit(LoginLoadingState());
        try {
          var login = await loginRepository.signInWithEmailAndPassword(
              event.email, event.password);

          await login?.fold((l) {
            emit(LoginErrorState(l.error));
          }, (response) async {
            await storage.write(key: 'token', value: response.user!.uid);
            emit(LoginSuccessState(response));
          });
        } catch (e) {
          emit(LoginErrorState('An unexpected error occurred: ${e.toString()}'));
        }
      } else {
        emit(LoginErrorState('Form validation failed. Please check your inputs.'));
      }
    });


    on<signInGoogleEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        var login = await loginRepository.signInWithGoogle();

        await login?.fold((l) {
          emit(LoginErrorState(l.error));
        }, (response) async {
          await storage.write(key: 'token', value: response.user!.uid);
          emit(LoginSuccessState(response));
        });
      } catch (e) {
        emit(LoginErrorState(
            'An error occurred during Google sign in: ${e.toString()}'));
      }
    });
  }
}

