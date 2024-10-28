import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/firebase/firebase_error_model.dart';

abstract class BaseLoginRepository {
  Future<Either<FirebaseErrorModel, UserCredential>?> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<FirebaseErrorModel, UserCredential>?> signInWithGoogle();
}
