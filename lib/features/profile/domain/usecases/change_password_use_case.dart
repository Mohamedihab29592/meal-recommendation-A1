import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordUseCase {
  final FirebaseAuth auth;

  ChangePasswordUseCase(this.auth);

  Future<void> call(String currentPassword, String newPassword) async {
    final user = auth.currentUser;
    if (user == null) throw Exception("User not authenticated");

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          throw Exception("The current password is incorrect.");
        }
      }
      throw Exception("Failed to change password: ${e.toString()}");
    }
  }
}
