import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;

  ProfileDataSourceImpl(this.firestore);

  @override
  Future<Map<String, dynamic>> getUserProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc.data()!;
    } else {
      throw Exception("User profile not found");
    }
  }
}

