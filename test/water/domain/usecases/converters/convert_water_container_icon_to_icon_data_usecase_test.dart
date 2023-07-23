import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sereno_clean_architecture_solid/core/error/exceptions.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/water_container_icon.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_icon_to_icon_data_usecase.dart';

void main() {
  var useCase = ConvertWaterContainerIconToIconDataUseCaseImp();

  test('Should return the correct IconData when icon is mapped', () async {
    IconData icon = CommunityMaterialIcons.cup_water;
    var waterContainerIcon = WaterContainerIcon.cup;

    var result = useCase(waterContainerIcon);

    expect(result, icon);
  });

  test('Should throw IconNotFoundException', () async {
    var waterContainerIcon = WaterContainerIcon.test;

    expect(() => useCase(waterContainerIcon), throwsA(const TypeMatcher<IconNotFoundException>()));
  });
}
