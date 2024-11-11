import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_recommendations/core/models/auth_action_params.dart';
import 'package:meal_recommendations/core/utils/functions/execute_and_handle_firebase_error.dart';
import 'package:meal_recommendations/features/auth/Login_Screen/data/data_source/login_datasource.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';
import '../../../../../core/firebase/firebase_error_model.dart';

class LoginRepo {
  final LoginDataSource _loginDataSource;

  LoginRepo(this._loginDataSource);

  Future<Either<FirebaseErrorModel, UserModel>> login(
    AuthActionParams params,
  ) {
    return executeAndHandleFirebaseErrors<UserModel>(
      () async => await _loginDataSource.login(params),
    );
  }

  Future<Either<FirebaseErrorModel, UserCredential>> googleLogin() {
    return executeAndHandleFirebaseErrors<UserCredential>(
      () async => await _loginDataSource.googleLogin(),
    );
  }
}
