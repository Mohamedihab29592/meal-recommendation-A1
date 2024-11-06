abstract class ProfileRepository {
  Future<Map<String, dynamic>> getUserProfile(String uid);
  Future<void> changePassword(String currentPassword, String newPassword);
}
