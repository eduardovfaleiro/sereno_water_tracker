import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/enums/water_container_icon.dart';

abstract interface class ConvertWaterContainerIconToIconDataUseCase {
  IconData call(WaterContainerIcon waterContainerIcon);
}

class ConvertWaterContainerIconToIconDataUseCaseImp implements ConvertWaterContainerIconToIconDataUseCase {
  @override
  IconData call(WaterContainerIcon waterContainerIcon) {
    switch (waterContainerIcon) {
      case WaterContainerIcon.cup:
        return CommunityMaterialIcons.cup_water;
      case WaterContainerIcon.bottle:
        return CommunityMaterialIcons.bottle_soda_classic;
      default:
        throw IconNotFoundException("WaterContainerIcon not mapped to IconData");
    }
  }
}
