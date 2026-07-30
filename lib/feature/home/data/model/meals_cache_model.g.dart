// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_cache_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealsCacheModelAdapter extends TypeAdapter<MealsCacheModel> {
  @override
  final int typeId = 2;

  @override
  MealsCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealsCacheModel(
      (fields[0] as List).cast<MealModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, MealsCacheModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.meals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealsCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
