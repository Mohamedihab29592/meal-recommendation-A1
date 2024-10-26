// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      imageUrl: json['image_url'] as String?,
      name: json['name'] as String?,
      dishName: json['dish_name'] as String?,
      cookTime: (json['cook_time'] as num?)?.toInt(),
      servingSize: (json['serving_size'] as num?)?.toInt(),
      summary: json['summary'] == null
          ? null
          : MealSummary.fromJson(json['summary'] as Map<String, dynamic>),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => MealIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      direction: (json['direction'] as List<dynamic>?)
          ?.map((e) => MealDirectionStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      mealType: json['meal_type'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      isFavourite: json['is_favourite'] as bool? ?? false,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'image_url': instance.imageUrl,
      'name': instance.name,
      'dish_name': instance.dishName,
      'meal_type': instance.mealType,
      'rating': instance.rating,
      'cook_time': instance.cookTime,
      'serving_size': instance.servingSize,
      'summary': instance.summary?.toJson(),
      'ingredients': instance.ingredients?.map((e) => e.toJson()).toList(),
      'direction': instance.direction?.map((e) => e.toJson()).toList(),
      'is_favourite': instance.isFavourite,
    };

MealSummary _$MealSummaryFromJson(Map<String, dynamic> json) => MealSummary(
      summary: json['summary'] as String,
      nutrations: (json['nutrations'] as List<dynamic>)
          .map((e) => MealNutrition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealSummaryToJson(MealSummary instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'nutrations': instance.nutrations.map((e) => e.toJson()).toList(),
    };

MealNutrition _$MealNutritionFromJson(Map<String, dynamic> json) =>
    MealNutrition(
      quantityInGrams: (json['quantity_in_grams'] as num).toInt(),
      nutrientName: json['nutrient_name'] as String,
    );

Map<String, dynamic> _$MealNutritionToJson(MealNutrition instance) =>
    <String, dynamic>{
      'quantity_in_grams': instance.quantityInGrams,
      'nutrient_name': instance.nutrientName,
    };

MealIngredient _$MealIngredientFromJson(Map<String, dynamic> json) =>
    MealIngredient(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      pieces: (json['pieces'] as num).toInt(),
    );

Map<String, dynamic> _$MealIngredientToJson(MealIngredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'pieces': instance.pieces,
    };

MealDirectionStep _$MealDirectionStepFromJson(Map<String, dynamic> json) =>
    MealDirectionStep(
      stepNumber: (json['step_number'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$MealDirectionStepToJson(MealDirectionStep instance) =>
    <String, dynamic>{
      'step_number': instance.stepNumber,
      'description': instance.description,
    };
