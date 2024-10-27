abstract class UserEvent {}

class SignUpEvent extends UserEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class SignOutEvent extends UserEvent {}

class ToggleTermsEvent extends UserEvent {
  final bool isAccepted;

  ToggleTermsEvent(this.isAccepted);
}
class TogglePasswordEvent extends UserEvent {
  final bool isPassword;

  TogglePasswordEvent(this.isPassword);
}
