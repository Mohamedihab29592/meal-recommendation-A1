import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> signOut();
}
