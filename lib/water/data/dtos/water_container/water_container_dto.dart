// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

import '../../../../core/utils/enums/water_container_icon.dart';

part 'water_container_dto.g.dart';

@HiveType(typeId: 1)
class WaterContainerDto {
  @HiveField(0)
  final WaterContainerIcon waterContainerIcon;

  @HiveField(1)
  final int amount;

  WaterContainerDto({
    required this.waterContainerIcon,
    required this.amount,
  });

  @override
  bool operator ==(covariant WaterContainerDto other) {
    if (identical(this, other)) return true;

    return other.waterContainerIcon == waterContainerIcon && other.amount == amount;
  }

  @override
  int get hashCode => waterContainerIcon.hashCode ^ amount.hashCode;
}
