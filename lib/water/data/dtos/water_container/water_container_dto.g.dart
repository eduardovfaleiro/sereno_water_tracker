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
      waterContainerIcon: fields[0] as WaterContainerIcon,
      amount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WaterContainerDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.waterContainerIcon)
      ..writeByte(1)
      ..write(obj.amount);
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
