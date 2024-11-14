import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/firebase/firebase_error_model.dart';
import '../../domain/repositories/BaseLoginDataSource.dart';
import '../../domain/repositories/BaseLoginRepository.dart';

class LoginRepositoryImpl implements BaseLoginRepository {
  final BaseLoginDataSource loginDataSource;

  LoginRepositoryImpl({required this.loginDataSource});

  @override
  Future<Either<FirebaseErrorModel, UserCredential>?>
      signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response =
        await loginDataSource.signInWithEmailAndPassword(email, password);

    return response;
  }

  @override
  Future<Either<FirebaseErrorModel, UserCredential>?> signInWithGoogle() async {
    final response = await loginDataSource.signInWithGoogle();

    return response?.fold(
        (error) => Left(error), (userCredential) => Right(userCredential));
  }
}
