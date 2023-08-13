// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_container_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterContainerEntityAdapter extends TypeAdapter<WaterContainerEntity> {
  @override
  final int typeId = 1;

  @override
  WaterContainerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterContainerEntity(
      assetName: fields[0] as String,
      amount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WaterContainerEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.assetName)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterContainerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
