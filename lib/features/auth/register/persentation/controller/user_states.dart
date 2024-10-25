import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {
  final bool termsAccepted;
  final bool isPassword;

  UserInitialState({this.termsAccepted = false, this.isPassword=false});
}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final UserModel user;

  UserSuccessState(this.user);
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);
}
