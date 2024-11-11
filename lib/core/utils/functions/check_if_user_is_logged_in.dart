import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';
import 'package:meal_recommendations/core/utils/constant.dart';
import 'package:meal_recommendations/core/utils/functions/cache_user_and_his_id.dart';

bool isUserLoggedIn = false;

Future<void> checkIfUserIsLoggedIn() async {
  final cachedUserId = await SecureStorageHelper.getSecuredString(
    CacheKeys.cachedUserId,
  );

  if (cachedUserId == null || cachedUserId.isEmpty) {
    isUserLoggedIn = false;
  } else {
    currentUser = await getCachedUserModel();
    isUserLoggedIn = true;
  }
}
