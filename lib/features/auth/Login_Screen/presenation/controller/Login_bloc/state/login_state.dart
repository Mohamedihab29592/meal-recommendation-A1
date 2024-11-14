

import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates {
UserCredential userCredential;
LoginSuccessState(this.userCredential);

}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}




