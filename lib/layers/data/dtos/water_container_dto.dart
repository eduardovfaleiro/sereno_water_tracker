// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../domain/entities/water_container_entity.dart';

class WaterContainerDto extends WaterContainerEntity {
  final int id;

  WaterContainerDto(super.ml, super.description, this.id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'ml': ml,
    };
  }

  factory WaterContainerDto.fromMap(Map<String, dynamic> map) {
    return WaterContainerDto(
      map['id'] as int,
      map['description'] as String,
      map['ml'] as int,
    );
  }
}
