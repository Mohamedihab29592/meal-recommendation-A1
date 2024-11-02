import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
class RemoteDataSourceFirebase {
  final firebase_auth.FirebaseAuth? _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;

  RemoteDataSourceFirebase({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final credential = await _firebaseAuth?.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential?.user == null) {
        throw Exception('Sign up failed: User is null after sign up.');
      }

      final user = credential!.user!;
      await user.updateDisplayName(fullName);
      await user.reload();  // Refresh the user's information

      // Call Firestore user creation
      // await userCreate(
      //   name: fullName,
      //   email: email,
      //   uid: user.uid,
      //   phone: phone,
      // );

      return UserModel(
        name: user.displayName,
        email: user.email,
        uId: user.uid,
        phone: user.phoneNumber,
        image: user.photoURL ?? 'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg',
      );
    } catch (error) {
      throw Exception('Sign up failed: $error');
    }
  }

  Future<void> userCreate({
    required String name,
    required String email,
    required String? uid,
    required String? phone,
  }) async {
    try {
      final model = UserModel(
          name: name,
          email: email,
          uId: uid,
          phone: phone,
          image: 'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'
      );

      await _firebaseFirestore.collection('users').doc(uid).set(model.toJson());
    } catch (error) {
      if (kDebugMode) {
        print('Firestore user creation failed: $error');
      }
      throw Exception('Firestore user creation failed');
    }
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Google sign-in canceled by user.');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth!.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) throw Exception('Sign-in failed: User is null after sign-in.');

      // Check if user exists in Firestore
      final userDoc = await _firebaseFirestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        // Create user in Firestore if not existing
        await userCreate(
          name: user.displayName ?? "No Name",
          email: user.email ?? "No Email",
          uid: user.uid,
          phone: user.phoneNumber,
        );
      }

      return UserModel(
        name: user.displayName,
        email: user.email,
        uId: user.uid,
        phone: user.phoneNumber,
        image: user.photoURL ?? 'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg',
      );
    } catch (error) {
      throw Exception('Google sign-in failed: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth?.signOut();
      await _googleSignIn.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}
