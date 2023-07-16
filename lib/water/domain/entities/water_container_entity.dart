import '../../../core/utils/enums/icon_name.dart';

class WaterContainerEntity {
  final String description;
  final IconName iconName;
  final int amount;

  WaterContainerEntity({
    required this.description,
    required this.iconName,
    required this.amount,
  });
}
