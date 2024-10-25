import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

import '../base_repo/user_repo.dart';

class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase(this.repository);

  Future<UserModel?> execute({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}
