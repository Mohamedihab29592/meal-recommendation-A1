// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavMealModelAdapter extends TypeAdapter<FavMealModel> {
  @override
  final int typeId = 0;

  @override
  FavMealModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavMealModel(
      id: fields[0] as int,
      title: fields[1] as String,
      imageUrl: fields[2] as String,
      dishName: fields[3] as String,
      mealType: fields[4] as String,
      rating: fields[5] as double,
      noOfIngredients: fields[6] as int,
      isFavourite: fields[7] as bool,
      noHours: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavMealModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.dishName)
      ..writeByte(4)
      ..write(obj.mealType)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.noOfIngredients)
      ..writeByte(7)
      ..write(obj.isFavourite)
      ..writeByte(8)
      ..write(obj.noHours);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavMealModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
