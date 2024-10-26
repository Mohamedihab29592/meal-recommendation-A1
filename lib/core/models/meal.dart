import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Meal {
  final String? imageUrl, name, dishName, mealType;
  final double? rating;
  final int? cookTime, servingSize;
  final MealSummary? summary;
  final List<MealIngredient>? ingredients;
  final List<String>? mealSteps;
  final bool isFavourite;

  Meal({
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

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MealSummary {
  final String summary;
  final List<MealNutrition> nutrations;

  MealSummary({
    required this.summary,
    required this.nutrations,
  });

  factory MealSummary.fromJson(Map<String, dynamic> json) =>
      _$MealSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$MealSummaryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MealNutrition {
  final int quantityInGrams;
  final String nutrientName;

  MealNutrition({
    required this.quantityInGrams,
    required this.nutrientName,
  });

  factory MealNutrition.fromJson(Map<String, dynamic> json) =>
      _$MealNutritionFromJson(json);

  Map<String, dynamic> toJson() => _$MealNutritionToJson(this);
}

@JsonSerializable()
class MealIngredient {
  final String name, imageUrl;
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
