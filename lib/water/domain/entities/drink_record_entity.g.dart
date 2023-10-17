// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_record_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrinkRecordEntityAdapter extends TypeAdapter<DrinkRecordEntity> {
  @override
  final int typeId = 2;

  @override
  DrinkRecordEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrinkRecordEntity(
      fields[0] as int,
      fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DrinkRecordEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrinkRecordEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
