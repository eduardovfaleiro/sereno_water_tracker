import 'package:hive/hive.dart';

part 'water_container_icon.g.dart';

@HiveType(typeId: 2)
enum WaterContainerIcon {
  @HiveField(0)
  cup,

  @HiveField(1)
  bottle,
}
