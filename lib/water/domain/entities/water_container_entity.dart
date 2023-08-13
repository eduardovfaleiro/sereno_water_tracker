// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'water_container_entity.g.dart';

@HiveType(typeId: 1)
class WaterContainerEntity {
  @HiveField(0)
  final String assetName;

  @HiveField(1)
  final int amount;

  const WaterContainerEntity({
    required this.assetName,
    required this.amount,
  });
}
