import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'otp_auth_state.dart';

class OtpAuthCubit extends Cubit<OtpAuthState> {
  OtpAuthCubit() : super(OtpAuthInitial());

  //todo : Register screen must handel the implementation of requesting OTP authentication and add verificationId;
  //todo  String verificationId='';

  Future<void> verifyOtp(
    String verificationId,
    String otpCode,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    emit(OtpAuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );

      await auth.signInWithCredential(credential);
      emit(OtpAuthSuccess());
    } catch (e) {
      emit(OtpAuthFailure(e.toString()));
    }
  }
}
