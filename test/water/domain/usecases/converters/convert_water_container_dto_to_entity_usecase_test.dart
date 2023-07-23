import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sereno_clean_architecture_solid/core/utils/enums/water_container_icon.dart';
import 'package:sereno_clean_architecture_solid/water/data/dtos/water_container/water_container_dto.dart';
import 'package:sereno_clean_architecture_solid/water/domain/entities/water_container_entity.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_dto_to_entity_usecase.dart';
import 'package:sereno_clean_architecture_solid/water/domain/usecases/converters/convert_water_container_icon_to_icon_data_usecase.dart';

class MockConvertWaterContainerIconToIconDataUseCase extends Mock implements ConvertWaterContainerIconToIconDataUseCase {}

void main() {
  late MockConvertWaterContainerIconToIconDataUseCase mockConvertWaterContainerIconToIconDataUseCase;
  late ConvertWaterContainerDtoToEntityUseCase useCase;

  setUp(() {
    mockConvertWaterContainerIconToIconDataUseCase = MockConvertWaterContainerIconToIconDataUseCase();
    useCase = ConvertWaterContainerDtoToEntityUseCaseImp(mockConvertWaterContainerIconToIconDataUseCase);

    registerFallbackValue(WaterContainerIcon.cup);
  });

  test('Should convert correctly', () async {
    const WaterContainerIcon waterContainerIcon = WaterContainerIcon.cup;
    const IconData iconData = CommunityMaterialIcons.cup_water;
    const int amount = 250;

    when(() => mockConvertWaterContainerIconToIconDataUseCase(any())).thenReturn(iconData);

    var waterContainerEntity = const WaterContainerEntity(icon: iconData, amount: amount);
    var waterContainerDto = WaterContainerDto(waterContainerIcon: waterContainerIcon, amount: amount);

    var result = useCase(waterContainerDto);

    verify(() => mockConvertWaterContainerIconToIconDataUseCase(waterContainerIcon));
    expect(result, waterContainerEntity);
  });
}
