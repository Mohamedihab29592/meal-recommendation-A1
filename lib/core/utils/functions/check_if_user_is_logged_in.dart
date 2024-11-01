import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';

bool isUserLoggedIn = false;

Future<void> checkIfUserIsLoggedIn() async {
  final cachedUserId = await SecureStorageHelper.getSecuredString(
    CacheKeys.cachedUserId,
  );

  if (cachedUserId == null || cachedUserId.isEmpty) {
    isUserLoggedIn = false;
  } else {
    isUserLoggedIn = true;
  }
}
