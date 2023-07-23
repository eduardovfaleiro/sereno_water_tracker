import 'package:flutter/material.dart';

import '../../../data/dtos/water_container/water_container_dto.dart';
import '../../entities/water_container_entity.dart';
import 'convert_water_container_icon_to_icon_data_usecase.dart';

abstract interface class ConvertWaterContainerDtoToEntityUseCase {
  WaterContainerEntity call(WaterContainerDto waterContainerDto);
}

class ConvertWaterContainerDtoToEntityUseCaseImp implements ConvertWaterContainerDtoToEntityUseCase {
  final ConvertWaterContainerIconToIconDataUseCase _convertWaterContainerIconToIconDataUseCase;

  ConvertWaterContainerDtoToEntityUseCaseImp(this._convertWaterContainerIconToIconDataUseCase);

  @override
  WaterContainerEntity call(WaterContainerDto waterContainerDto) {
    IconData icon = _convertWaterContainerIconToIconDataUseCase(waterContainerDto.waterContainerIcon);

    return WaterContainerEntity(amount: waterContainerDto.amount, icon: icon);
  }
}
