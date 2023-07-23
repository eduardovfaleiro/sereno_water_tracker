// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_container_icon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterContainerIconAdapter extends TypeAdapter<WaterContainerIcon> {
  @override
  final int typeId = 2;

  @override
  WaterContainerIcon read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WaterContainerIcon.cup;
      case 1:
        return WaterContainerIcon.bottle;
      case 2:
        return WaterContainerIcon.test;
      default:
        return WaterContainerIcon.cup;
    }
  }

  @override
  void write(BinaryWriter writer, WaterContainerIcon obj) {
    switch (obj) {
      case WaterContainerIcon.cup:
        writer.writeByte(0);
        break;
      case WaterContainerIcon.bottle:
        writer.writeByte(1);
        break;
      case WaterContainerIcon.test:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterContainerIconAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
