import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_recommendations/features/sidebar/data/models/header_model.dart';

class RemoteSideBarDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth? _firebaseAuth;


  RemoteSideBarDataSource({
    FirebaseFirestore? firebaseFirestore,
    firebase_auth.FirebaseAuth? firebaseAuth,

  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
       _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<HeaderModel> getHeader({required String uid}) async {
    try {
      DocumentSnapshot document = await _firebaseFirestore.collection("users").doc(uid).get();
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        return HeaderModel.fromJson(data);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
  Future<void> signOut() async {
    try {
      await _firebaseAuth?.signOut();
    } catch (error) {
      throw Exception('Sign out failed: $error');
    }
  }
}
