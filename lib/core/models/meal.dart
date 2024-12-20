import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

const int mealAdapterId = 0;
const int mealSummaryAdapterId = 1;
const int mealNutritionAdapterId = 2;
const int mealIngredientAdapterId = 3;

@HiveType(typeId: mealAdapterId)
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Meal {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? imageUrl;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final String? dishName;

  @HiveField(4)
  final String? mealType;

  @HiveField(5)
  final double? rating;

  @HiveField(6)
  final int? cookTime;

  @HiveField(7)
  final int? servingSize;

  @HiveField(8)
  final MealSummary? summary;

  @HiveField(9)
  final List<MealIngredient>? ingredients;

  @HiveField(10)
  final List<String>? mealSteps;

  @HiveField(11)
  final bool isFavourite;
  

  Meal({
    this.id,
    this.imageUrl,
    this.name,
    this.dishName,
    this.cookTime,
    this.servingSize,
    this.summary,
    this.ingredients,
    this.mealSteps,
    this.mealType,
    this.rating,
    this.isFavourite = false,
  });

  // Factory method to create Meal object from Firestore document
  factory Meal.fromDocument(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Meal(
      id: doc.id,
      dishName: data['dishName'],
      imageUrl: data['imageUrl'],
      name: data['name'],
      mealType: data['mealType'],
      rating: (data['rating'] as num?)?.toDouble(),
      cookTime: data['cookTime'],
      servingSize: data['servingSize'],
      summary: data['summary'] != null
          ? MealSummary.fromJson(data['summary'])
          : null,
      ingredients: data['ingredients'] != null
          ? (data['ingredients'] as List)
              .map((item) => MealIngredient.fromJson(item))
              .toList()
          : null,
      mealSteps: List<String>.from(data['mealSteps'] ?? []),
      isFavourite: data['isFavourite'] ?? false,
    );
  }

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}

@HiveType(typeId: mealSummaryAdapterId)
@JsonSerializable(explicitToJson: true)
class MealSummary {
  @HiveField(0)
  final String summary;

  @HiveField(1)
  final List<MealNutrition> nutrations;

  MealSummary({
    required this.summary,
    required this.nutrations,
  });

  factory MealSummary.fromJson(Map<String, dynamic> json) =>
      _$MealSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$MealSummaryToJson(this);
}

@HiveType(typeId: mealNutritionAdapterId)
@JsonSerializable(fieldRename: FieldRename.snake)
class MealNutrition {
  @HiveField(0)
  final int quantityInGrams;

  @HiveField(1)
  final String nutrientName;

  MealNutrition({
    required this.quantityInGrams,
    required this.nutrientName,
  });

  factory MealNutrition.fromJson(Map<String, dynamic> json) =>
      _$MealNutritionFromJson(json);

  Map<String, dynamic> toJson() => _$MealNutritionToJson(this);
}

@HiveType(typeId: mealIngredientAdapterId)
@JsonSerializable()
class MealIngredient {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final int pieces;

  MealIngredient({
    required this.imageUrl,
    required this.name,
    required this.pieces,
  });

  factory MealIngredient.fromJson(Map<String, dynamic> json) =>
      _$MealIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$MealIngredientToJson(this);
}
