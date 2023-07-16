// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

import '../../../../core/utils/enums/icon_name.dart';
import '../../../domain/entities/water_container_entity.dart';

part 'water_container_dto.g.dart';

@HiveType(typeId: 1)
class WaterContainerDto implements WaterContainerEntity {
  @HiveField(0)
  @override
  final String description;

  @HiveField(1)
  @override
  final IconName iconName;

  @HiveField(2)
  @override
  final int amount;

  @HiveField(3)
  final int id;

  WaterContainerDto({
    required this.id,
    required this.description,
    required this.iconName,
    required this.amount,
  });
}
