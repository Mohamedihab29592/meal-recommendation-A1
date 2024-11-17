import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';

class LogoutUseCase {
  Future<void> execute() async {
    await SecureStorageHelper.deleteSecuredString(CacheKeys.cachedUserId);
    await FirebaseAuth.instance.signOut();
    var box = await Hive.openBox('profileBox');
    await box.clear();
  }
}