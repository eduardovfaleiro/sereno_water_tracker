// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../core/utils/enums/water_container_icon.dart';

class WaterContainerEntity {
  final WaterContainerIcon waterContainerIcon;
  final int amount;

  const WaterContainerEntity({
    required this.waterContainerIcon,
    required this.amount,
  });

  @override
  bool operator ==(covariant WaterContainerEntity other) {
    if (identical(this, other)) return true;

    return other.waterContainerIcon == waterContainerIcon && other.amount == amount;
  }

  @override
  int get hashCode => waterContainerIcon.hashCode ^ amount.hashCode;
}
