import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_recommendations/features/profile/data/remote/profile_data_source.dart';

import '../../domain/usecases/change_password_use_case.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileDataSourceImpl(this.firestore, this.changePasswordUseCase);

  @override
    Future<Map<String, dynamic>> getUserProfile(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data()!;
      } else {
        throw FirebaseException(
          plugin: 'FirebaseFirestore',
          code: 'user-not-found',
          message: "User profile not found",
        );
      }
    } catch (error) {
      throw FirebaseException(
        plugin: 'FirebaseFirestore',
      );
    }
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    await changePasswordUseCase(currentPassword, newPassword);
  }
}

