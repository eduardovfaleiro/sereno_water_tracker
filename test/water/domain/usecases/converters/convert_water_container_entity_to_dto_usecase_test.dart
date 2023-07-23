import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/water_container_icon.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_icon_data_to_water_container_icon_usecase.dart.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_entity_to_dto_usecase.dart';

class MockConvertIconDataToWaterContainerIconUseCase extends Mock implements ConvertIconDataToWaterContainerIconUseCase {}

void main() {
  late MockConvertIconDataToWaterContainerIconUseCase mockConvertIconDataToWaterContainerIconUseCase;
  late ConvertWaterContainerEntityToDtoUseCase useCase;

  setUp(() {
    mockConvertIconDataToWaterContainerIconUseCase = MockConvertIconDataToWaterContainerIconUseCase();
    useCase = ConvertWaterContainerEntityToDtoUseCaseImp(mockConvertIconDataToWaterContainerIconUseCase);

    registerFallbackValue(const IconData(0));
  });

  test('Should convert correctly', () async {
    const WaterContainerIcon waterContainerIcon = WaterContainerIcon.cup;
    const IconData iconData = CommunityMaterialIcons.cup_water;
    const int amount = 250;

    when(() => mockConvertIconDataToWaterContainerIconUseCase(any())).thenReturn(waterContainerIcon);

    var waterContainerEntity = const WaterContainerEntity(
      icon: iconData,
      amount: amount,
    );

    var waterContainerDto = WaterContainerDto(waterContainerIcon: waterContainerIcon, amount: amount);

    var result = useCase(waterContainerEntity);

    expect(result, waterContainerDto);
  });
}
