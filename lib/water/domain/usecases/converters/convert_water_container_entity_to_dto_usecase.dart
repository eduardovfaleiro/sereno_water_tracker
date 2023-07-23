import '../../../../core/utils/enums/water_container_icon.dart';
import '../../../data/dtos/water_container/water_container_dto.dart';
import '../../entities/water_container_entity.dart';
import 'convert_icon_data_to_water_container_icon_usecase.dart.dart';

abstract interface class ConvertWaterContainerEntityToDtoUseCase {
  WaterContainerDto call(WaterContainerEntity waterContainerEntity);
}

class ConvertWaterContainerEntityToDtoUseCaseImp implements ConvertWaterContainerEntityToDtoUseCase {
  final ConvertIconDataToWaterContainerIconUseCase _convertIconDataToWaterContainerIconUseCase;

  ConvertWaterContainerEntityToDtoUseCaseImp(this._convertIconDataToWaterContainerIconUseCase);

  @override
  WaterContainerDto call(WaterContainerEntity waterContainerEntity) {
    WaterContainerIcon waterContainerIcon = _convertIconDataToWaterContainerIconUseCase(waterContainerEntity.icon);

    var waterContainerDto = WaterContainerDto(
      waterContainerIcon: waterContainerIcon,
      amount: waterContainerEntity.amount,
    );

    return waterContainerDto;
  }
}
