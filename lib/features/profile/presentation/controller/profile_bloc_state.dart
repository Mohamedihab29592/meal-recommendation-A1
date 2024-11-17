abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;

  ProfileLoaded(this.profileData);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
class PasswordChangeSuccess extends ProfileState {
  final String message;

  PasswordChangeSuccess(this.message);
}
class LogoutSuccess extends ProfileState {}

class LogoutError extends ProfileState {
  final String message;

  LogoutError(this.message);
}

class LogoutLoading extends ProfileState {}