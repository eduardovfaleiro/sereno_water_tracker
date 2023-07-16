// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IconNameAdapter extends TypeAdapter<IconName> {
  @override
  final int typeId = 2;

  @override
  IconName read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IconName.cup;
      default:
        return IconName.cup;
    }
  }

  @override
  void write(BinaryWriter writer, IconName obj) {
    switch (obj) {
      case IconName.cup:
        writer.writeByte(0);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
