import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../enums/water_container_icon.dart';

IconData getWaterContainerIcon(WaterContainerIcon icon) {
  switch (icon) {
    case WaterContainerIcon.cup:
      return CommunityMaterialIcons.cup;
    case WaterContainerIcon.bottle:
      return CommunityMaterialIcons.bottle_soda;
  }
}
