import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_recommendations/core/firebase/firebase_error_model.dart';
import '../../domain/repositories/BaseLoginDataSource.dart';

class LoginDataSourceImpl implements BaseLoginDataSource {
  static final auth = FirebaseAuth.instance;

  @override
  Future<Either<FirebaseErrorModel, UserCredential>?>
      signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(const FirebaseErrorModel(error: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return left(const FirebaseErrorModel(
            error: 'Wrong password provided for that user.'));
      } else {
        return left(const FirebaseErrorModel(error: 'error occurred.'));
      }
    } catch (e) {
      return left(
          FirebaseErrorModel(error: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<Either<FirebaseErrorModel, UserCredential>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return Right(
          await FirebaseAuth.instance.signInWithCredential(credential));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(
            const FirebaseErrorModel(error: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return left(const FirebaseErrorModel(
            error: 'Wrong password provided for that user.'));
      } else {
        return left(const FirebaseErrorModel(error: 'error occurred.'));
      }
    } catch (e) {
      return left(
          FirebaseErrorModel(error: 'An error occurred: ${e.toString()}'));
    }
  }
}
