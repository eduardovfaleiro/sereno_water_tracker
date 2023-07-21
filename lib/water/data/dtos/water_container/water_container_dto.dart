// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

import '../../../../core/utils/enums/water_container_icon.dart';
import '../../../domain/entities/water_container_entity.dart';

part 'water_container_dto.g.dart';

@HiveType(typeId: 1)
class WaterContainerDto implements WaterContainerEntity {
  @HiveField(0)
  @override
  final WaterContainerIcon waterContainerIcon;

  @HiveField(1)
  @override
  final int amount;

  WaterContainerDto({
    required this.waterContainerIcon,
    required this.amount,
  });

  factory WaterContainerDto.fromEntity(WaterContainerEntity waterContainerEntity) {
    return WaterContainerDto(
      waterContainerIcon: waterContainerEntity.waterContainerIcon,
      amount: waterContainerEntity.amount,
    );
  }

  WaterContainerEntity toEntity() {
    return WaterContainerEntity(
      amount: amount,
      waterContainerIcon: waterContainerIcon,
    );
  }

  @override
  bool operator ==(covariant WaterContainerDto other) {
    if (identical(this, other)) return true;

    return other.waterContainerIcon == waterContainerIcon && other.amount == amount;
  }

  @override
  int get hashCode => waterContainerIcon.hashCode ^ amount.hashCode;
}
