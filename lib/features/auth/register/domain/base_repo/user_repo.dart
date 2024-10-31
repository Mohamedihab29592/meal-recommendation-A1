import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  });
  Future<void> userCreate({
    required String name,
    required String email,
    required String? uid,
    required String? phone,
  });

  Future<void> signOut();
}
