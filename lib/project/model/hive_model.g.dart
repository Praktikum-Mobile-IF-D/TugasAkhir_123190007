// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyFavoriteAdapter extends TypeAdapter<MyFavorite> {
  @override
  final int typeId = 1;

  @override
  MyFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyFavorite(
      username: fields[0] as String?,
      nameMeal: fields[1] as String?,
      idMeal: fields[3] as String?,
      imageMeal: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyFavorite obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.nameMeal)
      ..writeByte(2)
      ..write(obj.imageMeal)
      ..writeByte(3)
      ..write(obj.idMeal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MyFavoriteAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class UserAccountModelAdapter extends TypeAdapter<UserAccountModel> {
  @override
  final int typeId = 2;

  @override
  UserAccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAccountModel(
      username: fields[0] as String,
      password: fields[1] as String,
      foto: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserAccountModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserAccountModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class MyRecipeModelAdapter extends TypeAdapter<MyRecipeModel> {
  @override
  final int typeId = 3;

  @override
  MyRecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyRecipeModel(
      username: fields[0] as String?,
      nameMeal: fields[1] as String?,
      imageMeal: fields[2] as String?,
      ingMeal1: fields[3] as String?,
      ingMeal2: fields[4] as String?,
      ingMeal3: fields[5] as String?,
      insMeal: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MyRecipeModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.nameMeal)
      ..writeByte(2)
      ..write(obj.imageMeal)
      ..writeByte(3)
      ..write(obj.ingMeal1)
      ..writeByte(4)
      ..write(obj.ingMeal2)
      ..writeByte(5)
      ..write(obj.ingMeal3)
      ..writeByte(6)
      ..write(obj.insMeal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MyRecipeModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
