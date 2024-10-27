import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
class RemoteDataSourceFirebase {

   final firebase_auth.FirebaseAuth? _firebaseAuth;

   RemoteDataSourceFirebase({
     firebase_auth.FirebaseAuth? firebaseAuth,
   }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;


  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      firebase_auth.UserCredential? credential =
      await _firebaseAuth?.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential?.user == null) {
        throw Exception('Sign up failed: The user is null after sign up.');
      }
      firebase_auth.User? user = credential?.user;
      if (user != null) {
        await user.updateDisplayName(fullName);
        await user.reload();  // Refresh the user's information
      }

      return UserModel(
        name: credential?.user!.displayName,
        email: credential?.user!.email,
        uId: credential?.user!.uid,
        phone:credential?.user!.phoneNumber,
        image:credential?.user!.photoURL??'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg',
      );
    } catch (error) {
      throw Exception('Sign up failed: $error');
    }
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<void> signOut() async {
     try {
      await _firebaseAuth?.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}