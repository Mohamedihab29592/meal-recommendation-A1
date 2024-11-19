import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/models/user.dart';

class LocalUserData {
  final String userBoxName = 'userBox';

  Future<void> saveUser(User user) async {
    final box = await Hive.openBox<User>(userBoxName);
    await box.put(user.userId, user);
  }

  Future<User?> getUser(String userId) async {
    final box = await Hive.openBox<User>(userBoxName);
    return box.get(userId);
  }

  Future<void> deleteUser(String userId) async {
    final box = await Hive.openBox<User>(userBoxName);
    await box.delete(userId);
  }
}
