// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealAdapter extends TypeAdapter<Meal> {
  @override
  final int typeId = 0;

  @override
  Meal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meal(
      id: fields[0] as String?,
      imageUrl: fields[1] as String?,
      name: fields[2] as String?,
      dishName: fields[3] as String?,
      cookTime: fields[6] as int?,
      servingSize: fields[7] as int?,
      summary: fields[8] as MealSummary?,
      ingredients: (fields[9] as List?)?.cast<MealIngredient>(),
      mealSteps: (fields[10] as List?)?.cast<String>(),
      mealType: fields[4] as String?,
      rating: fields[5] as double?,
      isFavourite: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Meal obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.dishName)
      ..writeByte(4)
      ..write(obj.mealType)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.cookTime)
      ..writeByte(7)
      ..write(obj.servingSize)
      ..writeByte(8)
      ..write(obj.summary)
      ..writeByte(9)
      ..write(obj.ingredients)
      ..writeByte(10)
      ..write(obj.mealSteps)
      ..writeByte(11)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealSummaryAdapter extends TypeAdapter<MealSummary> {
  @override
  final int typeId = 1;

  @override
  MealSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealSummary(
      summary: fields[0] as String,
      nutrations: (fields[1] as List).cast<MealNutrition>(),
    );
  }

  @override
  void write(BinaryWriter writer, MealSummary obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.summary)
      ..writeByte(1)
      ..write(obj.nutrations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealNutritionAdapter extends TypeAdapter<MealNutrition> {
  @override
  final int typeId = 2;

  @override
  MealNutrition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealNutrition(
      quantityInGrams: fields[0] as int,
      nutrientName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealNutrition obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.quantityInGrams)
      ..writeByte(1)
      ..write(obj.nutrientName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealNutritionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MealIngredientAdapter extends TypeAdapter<MealIngredient> {
  @override
  final int typeId = 3;

  @override
  MealIngredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealIngredient(
      imageUrl: fields[1] as String,
      name: fields[0] as String,
      pieces: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MealIngredient obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.pieces);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealIngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      id: json['id'] as String?,
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
      mealSteps: (json['meal_steps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mealType: json['meal_type'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      isFavourite: json['is_favourite'] as bool? ?? false,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'name': instance.name,
      'dish_name': instance.dishName,
      'meal_type': instance.mealType,
      'rating': instance.rating,
      'cook_time': instance.cookTime,
      'serving_size': instance.servingSize,
      'summary': instance.summary?.toJson(),
      'ingredients': instance.ingredients?.map((e) => e.toJson()).toList(),
      'meal_steps': instance.mealSteps,
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
