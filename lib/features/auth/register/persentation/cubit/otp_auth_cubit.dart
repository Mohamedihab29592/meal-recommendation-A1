import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'otp_auth_state.dart';

class OtpAuthCubit extends Cubit<OtpAuthState> {
  OtpAuthCubit() : super(OtpAuthInitial());

  void sendOtp(String email) {
    emit(OtpAuthLoading());
    try {
      //todo I will make the function o f sending otp to firebase after finishing register and login
    } catch (error) {
      emit(OtpAuthFailure(error.toString()));
    }
  }
}
