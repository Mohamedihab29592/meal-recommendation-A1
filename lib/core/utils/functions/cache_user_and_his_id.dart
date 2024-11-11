import 'dart:convert';

import 'package:meal_recommendations/core/helpers/cache_keys.dart';
import 'package:meal_recommendations/core/helpers/secure_storage_helper.dart';
import 'package:meal_recommendations/features/auth/register/data/models/user_model.dart';

Future<void> cacheUserAndHisId(UserModel userModel) async {
  await Future.wait([
    cacheUserModel(userModel),
    _cacheUserId(userModel.uId!),
  ]);
}

Future<void> _cacheUserId(String userId) async {
  await SecureStorageHelper.setSecuredString(CacheKeys.cachedUserId, userId);
}

Future<void> cacheUserModel(UserModel userModel) async {
  await SecureStorageHelper.setSecuredString(
    CacheKeys.cachedUser,
    json.encode(userModel.toJson()),
  );
}

Future<UserModel> getCachedUserModel() async {
  final String? user =
      await SecureStorageHelper.getSecuredString(CacheKeys.cachedUser);
  return UserModel.fromJson(json.decode(user!));
}
