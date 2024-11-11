abstract class LoginEvent {}

final class Login extends LoginEvent {}

final class TogglePasswordVisibilityEvent extends LoginEvent {}

final class GoogleLogin extends LoginEvent {}

final class AlwaysAutovalidateMode extends LoginEvent {}
