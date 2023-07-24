import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/enums/water_container_icon.dart';

abstract interface class ConvertIconDataToWaterContainerIconUseCase {
  WaterContainerIcon call(IconData icon);
}

class ConvertIconDataToWaterContainerIconUseCaseImp implements ConvertIconDataToWaterContainerIconUseCase {
  @override
  WaterContainerIcon call(IconData icon) {
    switch (icon) {
      case CommunityMaterialIcons.cup_water:
        return WaterContainerIcon.cup;
      case CommunityMaterialIcons.bottle_soda_classic:
        return WaterContainerIcon.bottle;
      default:
        throw IconNotFoundException("Icon not mapped to WaterContainerIcon");
    }
  }
}
