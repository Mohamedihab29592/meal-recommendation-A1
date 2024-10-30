import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 0)
class FavMealModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final String dishName;
  @HiveField(4)
  final String mealType;
  @HiveField(5)
  final double rating;
  @HiveField(6)
  final int noOfIngredients;
  @HiveField(7)
  final bool isFavourite;
  @HiveField(8)
  final String noHours;

  FavMealModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.dishName,
    required this.mealType,
    required this.rating,
    required this.noOfIngredients,
    required this.isFavourite,
    required this.noHours,
  });

  factory FavMealModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavMealModel(
      id: data['id'] ?? 0,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      dishName: data['dishName'] ?? '',
      mealType: data['mealType'] ?? '',
      rating: data['rating']?.toDouble() ?? 0.0,
      noOfIngredients: data['noOfIngredients'] ?? 0,
      isFavourite: data['isFavourite'] ?? false,
      noHours: data['noHours'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'dishName': dishName,
      'mealType': mealType,
      'rating': rating,
      'noOfIngredients': noOfIngredients,
      'isFavourite': isFavourite,
      'noHours': noHours,
    };
  }
}
