import 'package:hive/hive.dart';
import 'meal.dart'; 

part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final List<Meal> meals;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.meals = const [],
  });

  User copyWith({
    String? userId,
    String? name,
    String? email,
    List<Meal>? meals,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      meals: meals ?? this.meals,
    );
  }
}
