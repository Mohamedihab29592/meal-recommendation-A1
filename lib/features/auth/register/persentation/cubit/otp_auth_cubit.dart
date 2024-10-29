import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'otp_auth_state.dart';

class OtpAuthCubit extends Cubit<OtpAuthState> {
  OtpAuthCubit() : super(OtpAuthInitial());

  String verificationId = '';
  String phoneNumber = '';
  String otpCode = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          emit(OtpAuthFailure('invalid-phone-number'));
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  Future<void> verifyOtp() async {
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
