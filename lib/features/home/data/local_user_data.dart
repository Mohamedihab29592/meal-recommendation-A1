// ignore_for_file: avoid_print

import 'package:hive/hive.dart';
import 'package:meal_recommendations/core/models/user.dart';

class LocalUserData {
  final String userBoxName = 'userBox';

  Future<Box<User>> _openBox() async {
    return await Hive.openBox<User>(userBoxName);
  }

  Future<void> saveUser(User user) async {
    try {
      final box = await _openBox();
      await box.put(user.userId, user);
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  Future<User?> getUser(String userId) async {
    try {
      final box = await _openBox();
      return box.get(userId);
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final box = await _openBox();
      await box.delete(userId);
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<void> closeBox() async {
    final box = await _openBox();
    await box.close();
  }
}
