// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_container_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterContainerDtoAdapter extends TypeAdapter<WaterContainerDto> {
  @override
  final int typeId = 1;

  @override
  WaterContainerDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterContainerDto(
      id: fields[3] as int,
      description: fields[0] as String,
      iconName: fields[1] as IconName,
      amount: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WaterContainerDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.iconName)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterContainerDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
