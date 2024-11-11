import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_recommendations/core/firebase/firebase_collections.dart';
import 'package:meal_recommendations/core/services/di.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getFirebaseUserData(
  String userId,
) async {
  return await di
      .get<FirebaseFirestore>()
      .collection(FirebaseCollections.usersCollection)
      .doc(userId)
      .get();
}
