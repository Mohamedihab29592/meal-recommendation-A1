part of 'otp_auth_cubit.dart';

@immutable
abstract class OtpAuthState {}

class OtpAuthInitial extends OtpAuthState {}

class OtpAuthLoading extends OtpAuthState {}

class OtpAuthSuccess extends OtpAuthState {}

class OtpAuthFailure extends OtpAuthState {
  final String message;
  OtpAuthFailure(this.message);
}
