abstract class ProfileEvent {}

class FetchUserProfile extends ProfileEvent {
  final String uid;

  FetchUserProfile(this.uid);
}

class ChangePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;

  ChangePassword(this.currentPassword, this.newPassword);
}

